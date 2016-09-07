# Use zshcompletion
if [ -f $(brew --prefix)/etc/zsh_completion ]; then
	. $(brew --prefix)/etc/zsh_completion ]
fi


# Use antiword
source $(brew --prefix)/share/antigen.zsh

### Source universal config file
source ~/.crossrc

# added by travis gem
[ -f /Users/Alexander/.travis/travis.sh ] && source /Users/Alexander/.travis/travis.sh
