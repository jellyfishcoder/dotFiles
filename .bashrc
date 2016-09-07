### Custom Prompt
PROMPTLINE="1"
if [ PROMPTLINE = "1" ]
then
	source ~/.shell_prompt.sh
else
	export PS1="\[\033[38;5;4m\]\A>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;1m\][\$?]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;13m\]@\h\[$(tput sgr0)\]\[\033[38;5;2m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
fi

### Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'

# pip bash completion start
_pip_completion()
{
	COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
	COMP_CWORD=$COMP_CWORD \
	PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

### Import universal config file
source ~/.crossrc

# Import powerline
#if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
#	source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#fi
# Using xterm with color support
export TERM=xterm-256color
# Rbenv stuff
eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/Alexander/.travis/travis.sh ] && source /Users/Alexander/.travis/travis.sh

# Yagarto Cross Compiler Path
export PATH="$PATH:$HOME/yagarto/yagarto-4.7.2/bin"
export PATH="$PATH:$HOME/yagarto/yagarto-4.7.2/tools"

# added for perl stuff in local folder
export PATH="/Users/Alexander/perl5/bin${PATH:+:${PATH}}"
PERL5LIB="/Users/Alexander/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/Alexander/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/Alexander/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/Alexander/perl5"; export PERL_MM_OPT;
