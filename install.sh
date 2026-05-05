#!/usr/bin/env bash
# =============================================================================
# dotfiles/install.sh
# Bootstrap a fresh Linux machine with the full vim setup.
# Usage: bash install.sh
# =============================================================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
info()    { printf "\033[0;34m▌ %s\033[0m\n" "$*"; }
success() { printf "\033[0;32m▌ %s\033[0m\n" "$*"; }
warn()    { printf "\033[0;33m▌ %s\033[0m\n" "$*"; }
die()     { printf "\033[0;31m▌ ERROR: %s\033[0m\n" "$*" >&2; exit 1; }

# -----------------------------------------------------------------------------
# 1. Detect package manager
# -----------------------------------------------------------------------------
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

# -----------------------------------------------------------------------------
# 2. System packages
# -----------------------------------------------------------------------------
info "Updating package index..."
eval "$PKG_UPDATE"

for pkg in vim git stow curl; do
    if ! command -v "$pkg" &>/dev/null; then
        info "Installing $pkg..."
        eval "$PKG_INSTALL $pkg"
    else
        success "$pkg already installed"
    fi
done

# -----------------------------------------------------------------------------
# 3. vim-plug
# -----------------------------------------------------------------------------
VIM_PLUG="$HOME/.vim/autoload/plug.vim"
if [[ ! -f "$VIM_PLUG" ]]; then
    info "Installing vim-plug..."
    curl -fLo "$VIM_PLUG" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    success "vim-plug installed"
else
    success "vim-plug already present"
fi

# -----------------------------------------------------------------------------
# 4. GNU Stow — symlink the vim package
# -----------------------------------------------------------------------------
info "Stowing vim config..."

# Remove any plain files that would conflict with stow symlinks
[[ -f "$HOME/.vimrc" && ! -L "$HOME/.vimrc" ]] && {
    warn "Backing up existing ~/.vimrc → ~/.vimrc.bak"
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak"
}

cd "$DOTFILES_DIR"
stow --restow vim
success "vim package stowed"

# -----------------------------------------------------------------------------
# 5. undodir
# -----------------------------------------------------------------------------
mkdir -p "$HOME/.vim/undodir"
success "undodir ready"

# -----------------------------------------------------------------------------
# 6. Install vim plugins headlessly
# -----------------------------------------------------------------------------
info "Installing vim plugins (this may take a moment)..."
vim -es -u "$HOME/.vimrc" -i NONE \
    -c "PlugInstall" \
    -c "qa!" 2>/dev/null || true
success "Plugins installed"

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
printf "\n"
success "All done. Open vim and enjoy candle-light."
