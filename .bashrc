### Custom Prompt
export PS1="\[\033[38;5;4m\]\A>\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;1m\][\$?]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[\033[38;5;13m\]@\h\[$(tput sgr0)\]\[\033[38;5;2m\]:\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

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
if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
	source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi
# Using xterm with color support
export TERM=xterm-256color
# Rbenv stuff
eval "$(rbenv init -)"

# added by travis gem
[ -f /Users/Alexander/.travis/travis.sh ] && source /Users/Alexander/.travis/travis.sh
