## glabrego dotfiles
Use it well :)

## What's included?

- `nvim/` - Neovim configuration (LazyVim-based)
- `.tmux.conf` - Tmux configuration with plugins
- `.zshrc` - Zsh shell configuration
- `.aliases` - Shell aliases for development
- `.functions` - Custom shell functions
- `Brewfile` - Homebrew packages and applications

## Installation

Run the setup script to install everything:

```sh
./setup.sh
```

The script will:
1. Install Homebrew (if not already installed)
2. Install all packages from Brewfile
3. Set up Zsh as default shell
4. Create symlinks for all configuration files
5. Configure Neovim

## Neovim Setup

This repository includes a complete Neovim configuration based on LazyVim. The setup script automatically symlinks `nvim/` to `~/.config/nvim/`.

**Included plugins:**
- Telescope (fuzzy finder)
- Copilot (AI pair programming)
- Treesitter (syntax highlighting)
- nvim-tree (file explorer)
- LSP configuration
- Autocompletion
- Catppuccin theme
- Markview (markdown rendering)

After running `setup.sh`, launch Neovim and it will automatically install all plugins via lazy.nvim.
