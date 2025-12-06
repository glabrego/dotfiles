# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# get my personalized functions and aliases
source ~/.functions
source ~/.aliases
export EDITOR=nvim

# Fzf configs and ripgrep
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!.git/*" -g "!public/*" -g "!tmp/*" -g "!log/*" -g "!node_modules/*"'
