# {mark} Homebrew PATH
export PATH="/opt/homebrew/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"

# Git configuration
export GIT_USER_NAME="Guilherme Labrego"
export GIT_USER_EMAIL="glabrego@gmail.com"

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

# SETUP 1Password CLI
eval "$(op completion zsh)"; compdef _op op

# SETUP Starship Prompt
eval "$(starship init zsh)"

# SETUP Atuin
eval "$(atuin init zsh)"

# SETUP Zoxide
eval "$(zoxide init zsh)"

# Feedbin CLI credentials (1Password)
# Feedbin email is stored in the "username" field.
export OP_FEEDBIN_USERNAME_REF="${OP_FEEDBIN_USERNAME_REF:-op://Personal/Feedbin/username}"
export OP_FEEDBIN_PASSWORD_REF="${OP_FEEDBIN_PASSWORD_REF:-op://Personal/Feedbin/password}"
export OP_FEEDBIN_CACHE_FILE="${OP_FEEDBIN_CACHE_FILE:-${XDG_CACHE_HOME:-$HOME/.cache}/feedbin.env}"
export OP_FEEDBIN_CACHE_TTL="${OP_FEEDBIN_CACHE_TTL:-2592000}" # 30d

op_env_setup "$OP_FEEDBIN_CACHE_FILE" "$OP_FEEDBIN_CACHE_TTL" \
  "FEEDBIN_EMAIL=$OP_FEEDBIN_USERNAME_REF" \
  "FEEDBIN_PASSWORD=$OP_FEEDBIN_PASSWORD_REF"
