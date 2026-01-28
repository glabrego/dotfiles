## glabrego dotfiles
Use it well :)

## Prerequisites

- macOS (Intel or Apple Silicon)
- Command Line Tools (automatically installed by the setup script if missing)
- SSH keys configured (optional, for cloning private repositories)

## What's included?

- `nvim/` - Neovim configuration (LazyVim-based)
- `ghostty/` - Ghostty terminal configuration
- `atuin/` - Atuin shell history configuration
- `karabiner/` - Karabiner keyboard customization
- `starship.toml` - Starship prompt configuration
- `.tmux.conf` - Tmux configuration with plugins
- `.zshrc` - Zsh shell configuration
- `.aliases` - Shell aliases for development
- `.functions` - Custom shell functions
- `Brewfile` - Homebrew packages and applications
- `setup.sh` - Installation script
- `update.sh` - Update script for maintaining tools and configs

## Installation

Clone this repository and run the setup script:

```sh
git clone git@github.com:glabrego/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
./setup.sh
```

The script will:
1. Check and install Command Line Tools (if needed)
2. Add SSH keys to ssh-agent (if present)
3. Install Homebrew (if not already installed)
4. Create workspace directory
5. Clone personal repositories
6. Install all packages from Brewfile (112+ packages)
7. Set up Zsh as default shell (with Apple Silicon support)
8. Create symlinks for all configuration files
9. Install Tmux plugins automatically via TPM
10. Configure and install Neovim plugins automatically via Lazy.nvim
11. Set up Ghostty, Atuin, and Karabiner configurations
12. Configure macOS system defaults
13. Verify installation and show results

**Features:**
- ✅ Idempotent - Safe to run multiple times
- ✅ Works on both Intel and Apple Silicon Macs
- ✅ Automatic error handling with graceful failures
- ✅ No manual plugin installation needed
- ✅ Post-install verification with clear results

## Updating

Keep your dotfiles and tools up to date:

```sh
cd ~/workspace/dotfiles
./update.sh
```

The update script will:
- Pull latest dotfiles from git
- Update Homebrew and all packages
- Update Tmux plugins via TPM
- Update Neovim plugins via Lazy.nvim
- Sync Atuin shell history
- Clean up Homebrew cache

## macOS System Defaults

The setup script configures sensible macOS defaults:

**Keyboard:**
- Faster key repeat rate
- Shorter initial key repeat delay

**Finder:**
- Show hidden files
- Show path bar and status bar
- Show full POSIX path in title

**Dock:**
- Auto-hide enabled
- Hide recent applications
- Minimize windows to application icon

**Screenshots:**
- Save to Desktop as PNG
- Disable shadows

**Trackpad:**
- Tap to click enabled

These settings take effect immediately (affected apps are restarted automatically).

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

The setup script automatically installs all plugins via lazy.nvim - no manual intervention needed!

## Tmux Configuration

Tmux multiplexer with automatic plugin installation via TPM:
- **Theme:** Catppuccin Mocha
- **Plugins:** tmux-sensible, tmux-autoreload, vim-tmux-navigator, tmux-battery
- **Prefix:** Changed from C-b to C-a
- **Split panes:** `/` for horizontal, `-` for vertical
- **Vim mode:** Enabled with vi keybindings

## Starship Prompt

Custom Starship prompt configuration with Catppuccin Mocha theme. Features:
- Username display
- Directory path with truncation
- Git branch and status
- Current time
- Vim mode indicators

## Ghostty Terminal

Ghostty terminal emulator configuration:
- JetBrainsMono Nerd Font Mono (size 15)
- Catppuccin Mocha theme

## Atuin Shell History

Atuin shell history configuration:
- Compact UI style
- Disabled enter_accept (tab to edit before executing)
- Sync v2 enabled

## Karabiner Elements

Karabiner keyboard customization configuration:
- Caps Lock → Left Control
- Fn → Hyper key (Command+Control+Option+Shift)
- F1/F2 → Brightness controls

## Troubleshooting

### Command Line Tools Installation
If the script exits asking you to install Command Line Tools:
1. Complete the installation dialog that appears
2. Wait for installation to finish (may take several minutes)
3. Re-run `./setup.sh`

### SSH Keys
If you don't have SSH keys set up:
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Then add the public key to your GitHub account.

### Script Fails During Homebrew Installation
If Homebrew installation fails, you may need to:
1. Check your internet connection
2. Ensure you have enough disk space
3. Run the script again (it's idempotent)

### Re-running the Script
The setup script is safe to run multiple times. It will:
- Skip already installed packages
- Update existing symlinks
- Not re-clone existing repositories
