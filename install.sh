#!/usr/bin/env bash
# =============================================================================
# dotfiles/install.sh
# Bootstrap a fresh Linux machine with the full setup.
# Usage: bash install.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info()    { printf "\033[38;2;200;149;90m▌ %s\033[0m\n" "$*"; }
success() { printf "\033[38;2;122;106;85m▌ %s\033[0m\n" "$*"; }
warn()    { printf "\033[38;2;217;153;98m▌ %s\033[0m\n" "$*"; }
die()     { printf "\033[38;2;204;51;51m▌ ERROR: %s\033[0m\n" "$*" >&2; exit 1; }

if command -v apt-get &>/dev/null; then
    PKG_INSTALL="sudo apt-get install -y"
    PKG_UPDATE="sudo apt-get update -y"
elif command -v pacman &>/dev/null; then
    PKG_INSTALL="sudo pacman -S --noconfirm"
    PKG_UPDATE="sudo pacman -Sy"
elif command -v dnf &>/dev/null; then
    PKG_INSTALL="sudo dnf install -y"
    PKG_UPDATE="sudo dnf check-update || true"
else
    die "No supported package manager found (apt, pacman, dnf)."
fi

info "Updating package index..."
eval "$PKG_UPDATE"

for pkg in vim git stow curl fzf; do
    if ! command -v "$pkg" &>/dev/null; then
        info "Installing $pkg..."
        eval "$PKG_INSTALL $pkg"
    else
        success "$pkg already installed"
    fi
done

if ! command -v starship &>/dev/null; then
    info "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    success "Starship installed"
else
    success "Starship already installed"
fi

if ! command -v zoxide &>/dev/null; then
    info "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    success "Zoxide installed"
else
    success "Zoxide already installed"
fi

FONT_DIR="$HOME/.local/share/fonts"
if ! fc-list | grep -qi "JetBrainsMono Nerd"; then
    info "Installing JetBrains Mono Nerd Font..."
    mkdir -p "$FONT_DIR"
    curl -fLo /tmp/JetBrainsMono.zip \
        "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR/JetBrainsMono" '*.ttf' 2>/dev/null
    fc-cache -f "$FONT_DIR"
    rm /tmp/JetBrainsMono.zip
    success "JetBrains Mono Nerd Font installed"
else
    success "JetBrains Mono Nerd Font already installed"
fi

VIM_PLUG="$HOME/.vim/autoload/plug.vim"
if [[ ! -f "$VIM_PLUG" ]]; then
    info "Installing vim-plug..."
    curl -fLo "$VIM_PLUG" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    success "vim-plug installed"
else
    success "vim-plug already present"
fi

info "Stowing packages..."
cd "$DOTFILES_DIR"

stow_package() {
    local pkg="$1"; shift
    for f in "$@"; do
        [[ -f "$HOME/$f" && ! -L "$HOME/$f" ]] && {
            warn "Backing up ~/$f → ~/$f.bak"
            mv "$HOME/$f" "$HOME/$f.bak"
        }
    done
    stow --restow "$pkg"
    success "$pkg stowed"
}

stow_package vim .vimrc
stow_package bash .bashrc
stow_package starship

mkdir -p "$HOME/.vim/undodir"
success "undodir ready"

info "Installing vim plugins..."
vim -es -u "$HOME/.vimrc" -i NONE -c "PlugInstall" -c "qa!" 2>/dev/null || true
success "Plugins installed"

DCONF_FILE="$DOTFILES_DIR/terminal/candle-light.dconf"
if command -v dconf &>/dev/null && [[ -f "$DCONF_FILE" ]]; then
    info "Loading terminal color profile..."
    dconf load /org/gnome/terminal/legacy/profiles:/ < "$DCONF_FILE"
    success "Terminal profile loaded"
else
    warn "dconf not found — load terminal/candle-light.dconf manually"
fi

printf "\n"
success "All done. Restart your terminal to see the changes."
info "Tip: the font change needs a terminal restart to take effect."
