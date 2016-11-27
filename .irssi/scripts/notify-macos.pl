#!/usr/bin/env perl

##
# This script provides integration between Irssi and the macOS Notification
# Center, so that highlights, private messages, and notices produce a standard
# notification pop-up.
#
# Requirements:
# - Irssi (obv)
# - terminal-notifier (https://github.com/julienXX/terminal-notifier)
# - File::Which and String::ShellQuote Perl modules (install with `cpan`)
# - macOS (née OS X) version 10.8 or higher
#
# Installation:
# - Move/copy/symlink to ~/.irssi/scripts/
# - Run `/script load notify-macos` in Irssi
#
# @copyright © dana geier <https://github.com/okdana>
# @license   MIT

use strict;
use lib '/usr/local/lib/perl5/site_perl/darwin-thread-multi-2level';
use feature qw(say);
use File::Which;
use String::ShellQuote;
use Irssi;
use vars qw($NOTIFY_SOUND $NOTIFY_SENDER $CHECK_FOCUS $DEBUG);
use vars qw($VERSION %IRSSI);
use vars qw($MSGLEVEL_NOTICES $MSGLEVEL_HILIGHT);

# Set this to one of the following:
# - '' to disable sound
# - 'default' to use default notification sound
# - The name of an alert sound listed in System Preferences > Sound to use it.
#   Capitalisation matters. Example: 'Sosumi'
$NOTIFY_SOUND = 'default';

# Set this to one of the following:
# - '' to use default icon
# - The bundle identifier of an installed application to use its icon.
#   Example: 'com.skype.skype'
$NOTIFY_SENDER = '';

# Set this to 1 if you want the script to try to avoid notifying when Terminal
# is the front-most application and its front-most selected tab has Irssi
# running in it (won't work if you use `screen` or similar)
$CHECK_FOCUS = 0;

# Set this to 1 to print some debug information to Irssi (warning: noisy!)
$DEBUG = 0;

# Don't edit below this line unless you know what you're doing
$VERSION = '0.1.0';
%IRSSI   = (
	name        => 'notify-macos',
	description => 'macOS Notification Center integration for Irssi',
	authors     => 'dana geier',
	contact     => 'dana@dana.is',
	license     => 'MIT',
	url         => 'https://github.com/okdana/irssi-notify-macos',
);

# We have to hard-code these in, because we want to be able to test the script
# from the command line, and Irssi.pm will not export its constants unless it's
# actually running in Irssi
$MSGLEVEL_NOTICES = 0x0000008;
$MSGLEVEL_HILIGHT = 0x0200000;

##
# Handles notifications for 'print text' signal.
#
# Takes event text in the form '<.nick> message', '* nick message', or similar.
#
# @param $dest     An object of class Irssi::UI::TextDest.
# @param $text     The 'rich' text (potentially including colours, &c.).
# @param $stripped The 'plain' text (with formatting stripped).
#
# @return 0 on error, >0 on success.
sub handle_print_text {
	my ($dest, $text, $stripped) = @_;
	my $channel  = $dest->{target};
	my $nick     = $stripped;
	my $message  = $stripped;
	my $fmt      = 'Message from %s on %s';

	if ( $DEBUG && $dest->{server} ) {
		Irssi::print('server:   ' . $dest->{server});
		Irssi::print('target:   ' . $dest->{target});
		Irssi::print('level:    ' . $dest->{level});
		Irssi::print('text:     ' . $text);
		Irssi::print('stripped: ' . $stripped);
	}

	return 0 if ! (
		($dest->{level} & $MSGLEVEL_HILIGHT)
		||
		($dest->{level} & $MSGLEVEL_NOTICES)
	);
	return 0 if $CHECK_FOCUS && irssi_is_focussed();

	# <.nick> <message>
	if ( $stripped =~ m/^</ ) {
		$nick    =~ s/^<.(.+?)>.*/\1/;
		$message =~ s/^<.+?>\s+//;
	# * nick message
	} elsif ( $stripped =~ m/^\*/ ) {
		$nick    =~ s/^\*\s+(.+?)\s.*/\1/;
	# -nick- message
	} elsif ( $stripped =~ m/^-/ ) {
		$nick    =~ s/^-(.+?)-.*/\1/;
		$message =~ s/^-.+?-\s+//;
		$fmt     =  'Notice from %s';
	}

	return notify(sprintf($fmt, $nick, $channel), $message);
}

##
# Handles notifications for 'message private' signal.
#
# @param $message The received private message text.
# @param $nick    The sender nick.
# @param $address The sender address (nick host).
#
# @return 0 on error, >0 on success.
sub handle_message_private {
	my ($server, $message, $nick, $address) = @_;

	return 0 if $CHECK_FOCUS && irssi_is_focussed();

	return notify("Private message from ${nick}", $message);
}

##
# Returns whether Irssi is currently focussed.
#
# @return
#   1 if Terminal is focussed and its front-most focussed tab has Irssi running
#   in it; 0 if not.
sub irssi_is_focussed {
	my $applescript = shell_quote('
		tell application "System Events"
			set bid to bundle identifier of first process whose frontmost is true

			if bid is not "com.apple.Terminal" then
				error "Terminal not front-most application"
			end if

			tell application "Terminal"
				if processes of selected tab of front window does not contain "irssi" then
					error "irssi not in processes"
				end if
				return true
			end tell
		end tell
	');

	chomp(my $ret = `osascript -e ${applescript} 2>&1`);
	return $ret == 'true' ? 1 : 0;
}

##
# Sends notification via `terminal-notifier`.
#
# @param $title   The text to use as the notification title.
# @param $message The text to use as the notification message/body.
#
# @return 0 on error, >0 on success.
sub notify {
	my ($title, $message) = @_;
	my @args;

	# `terminal-notifier` requires that brackets at the beginning of the message
	# be escaped, i guess because it might be parsed as a plist otherwise...?
	$message = '\\' . $message if $message =~ m/^[{[<]/;

	@args = (
		'terminal-notifier',
		'-title',
		$title,
		'-message',
		$message,
	);
	push @args, ('-sound',  $NOTIFY_SOUND)  if $NOTIFY_SOUND;
	push @args, ('-sender', $NOTIFY_SENDER) if $NOTIFY_SENDER;

	return system(@args) == 0;
}

# Make sure `terminal-notifier` is installed
die('terminal-notifier not found — try `brew install terminal-notifier`')
	unless which('terminal-notifier');

# Register signal handlers if we're being called by Irssi
if (caller) {
	Irssi::signal_add('print text',      'handle_print_text');
	Irssi::signal_add('message private', 'handle_message_private');

# Otherwise, we'll simulate a signal for testing from the command line
} else {
	die("usage: ${0} <nick> <message>") unless $#ARGV >= 1;

	my $dest = bless({
		'server' => 0,
		'target' => '#cli',
		'level'  => $MSGLEVEL_HILIGHT,
	}, 'Irssi::UI::TextDest');
	my $nick     = $ARGV[0];
	my $message  = join(' ', @ARGV[1..($#ARGV)]);
	my $text     = "<+${nick}> ${message}";

	say "Got nick:          ${nick}";
	say "Got message:       ${message}";
	say "Printing text:     ${text}";
	say 'Irssi is focussed: ' . irssi_is_focussed();

	exit(!handle_print_text($dest, $text, $text));
}

1;

