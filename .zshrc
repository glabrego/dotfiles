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

feedbin_load_from_cache() {
  [[ -r "$OP_FEEDBIN_CACHE_FILE" ]] || return 1
  # shellcheck disable=SC1090
  source "$OP_FEEDBIN_CACHE_FILE"
  [[ -n "$FEEDBIN_EMAIL" && -n "$FEEDBIN_PASSWORD" ]]
}

feedbin_cache_is_fresh() {
  [[ -r "$OP_FEEDBIN_CACHE_FILE" ]] || return 1
  local now mtime
  now="$(date +%s)"
  mtime="$(stat -f %m "$OP_FEEDBIN_CACHE_FILE" 2>/dev/null || stat -c %Y "$OP_FEEDBIN_CACHE_FILE" 2>/dev/null)" || return 1
  (( now - mtime < OP_FEEDBIN_CACHE_TTL ))
}

if ! (feedbin_cache_is_fresh && feedbin_load_from_cache); then
  if command -v op >/dev/null 2>&1; then
    feedbin_username="$(op read "$OP_FEEDBIN_USERNAME_REF" 2>/dev/null)"
    feedbin_password="$(op read "$OP_FEEDBIN_PASSWORD_REF" 2>/dev/null)"

    if [[ -n "$feedbin_username" ]]; then
      export FEEDBIN_EMAIL="$feedbin_username"
    fi

    if [[ -n "$feedbin_password" ]]; then
      export FEEDBIN_PASSWORD="$feedbin_password"
    fi

    if [[ -n "$FEEDBIN_EMAIL" && -n "$FEEDBIN_PASSWORD" ]]; then
      mkdir -p "$(dirname "$OP_FEEDBIN_CACHE_FILE")"
      umask 077
      cat > "$OP_FEEDBIN_CACHE_FILE" <<EOF
export FEEDBIN_EMAIL=$(printf '%q' "$FEEDBIN_EMAIL")
export FEEDBIN_PASSWORD=$(printf '%q' "$FEEDBIN_PASSWORD")
EOF
    fi

    unset feedbin_username feedbin_password
  fi
fi
