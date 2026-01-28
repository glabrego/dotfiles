# {mark} Homebrew PATH
export PATH="/opt/homebrew/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# get my personalized functions and aliases
source ~/.functions
source ~/.aliases
export EDITOR=nvim

# SETUP ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Fzf configs and ripgrep
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!.git/*" -g "!public/*" -g "!tmp/*" -g "!log/*" -g "!node_modules/*"'

# SETUP Starship Prompt
eval "$(starship init zsh)"

# SETUP Atuin
eval "$(atuin init zsh)"

# SETUP Zoxide
eval "$(zoxide init zsh)"
