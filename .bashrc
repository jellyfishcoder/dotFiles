### Infection Checks

### Cool Thing
#if [ $(which screenfetch) ]; then screenfetch; fi

### Custom Prompt 
## Settings
CLR_SEQ="\[\e[m\]"
SEP_CHR=""
DEF_BAG=iTerm
# Time Segment (Yellow Bg, Thin Grey Fg)
TIME_BG=43
TIME_BG_SEP=33
TIME_FG=30
TIME_OT=8

# Error Segment (Red Bg, Blinking Bold White Fg)
ERRR_BG=41
ERRR_BG_SEP=31
ERRR_FG=37
ERRR_OT="1;5"

# Username Segment (Grey Bg, Green Fg)
URNM_BG=22

## Macros
function set_iterm2_badge() {
	printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n $1 | base64)
}

function nonzero_return() {
	RETVAL=$?
	set_iterm2_badge $DEF_BAG
	if [ $RETVAL -ne 0 ]; then
		echo -n "[$RETVAL]"
		set_iterm2_badge "ES: $RETVAL"
	fi
}

## Segments
TIME_SG="\[\e[${TIME_FG};${TIME_BG};${TIME_OT}m\]\A${CLR_SEQ}\[\e[${TIME_BG_SEP};${ERRR_BG}m\]${SEP_CHR}${CLR_SEQ}"
ERRR_SG="\[\e[${ERRR_FG};${ERRR_BG};${ERRR_OT}m\]\`nonzero_return\`${CLR_SEQ}\[\e[${ERRR_BG_SEP}m\]${SEP_CHR}${CLR_SEQ}"

export PS1=${TIME_SG}${ERRR_SG}

#export PS1="\[\033[30;8;43m\]\A\[$(tput sgr0)\]\[\033[33;41m\]\[\033[37;41;1;5m\] [\$?]\[$(tput sgr0)\]\[\033[31;40m\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;13m\]@\h\[$(tput sgr0)\]\[\033[38;5;2m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

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

# Using xterm with color support
export TERM=xterm-256color
# Rbenv stuff
eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/Alexander/.travis/travis.sh ] && source /Users/Alexander/.travis/travis.sh 
