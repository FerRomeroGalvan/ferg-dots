# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── install.sh          ← run this on a fresh machine
└── vim/                ← stow package
    ├── .vimrc
    └── .vim/
        ├── colors/
        │   └── candle-light.vim
        └── undodir/    ← persistent undo history (gitignored)
```

Each top-level folder is a **stow package**. Running `stow vim` creates
symlinks from `~/.vimrc` and `~/.vim/` pointing back into this repo.
Edit the files here — changes are live immediately.

## Fresh machine setup

```bash
git clone git@github.com:you/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

The script will:
1. Install `vim`, `git`, `stow`, `curl` via your system package manager
2. Install [vim-plug](https://github.com/junegunn/vim-plug)
3. Stow the `vim` package (backs up any existing `~/.vimrc` first)
4. Create `~/.vim/undodir`
5. Run `PlugInstall` headlessly

## Adding more packages

Create a new folder mirroring the paths relative to `$HOME`:

```bash
mkdir -p dotfiles/bash
cp ~/.bashrc dotfiles/bash/.bashrc
cd dotfiles && stow bash
```

Then commit and push.

## Plugins used

| Plugin | Purpose |
|--------|---------|
| preservim/nerdtree | File tree |
| Xuyuanp/nerdtree-git-plugin | Git status in tree |
| tpope/vim-fugitive | Git commands |
| vim-airline/vim-airline | Status bar |
| dense-analysis/ale | Linting (ruff, mypy) |
| sheerun/vim-polyglot | Language pack |
| ryanoasis/vim-devicons | Icons |
| wfxr/minimap.vim | Code minimap |
| airblade/vim-gitgutter | Git diff gutter |
| vim-test/vim-test | Test runner |

## Notes

- `undodir/` is tracked with a `.gitkeep` but its contents are gitignored
- Python linting requires `ruff` and `mypy` on your `$PATH`
- Nerd Fonts required for devicons (e.g. [JetBrains Mono Nerd Font](https://www.nerdfonts.com/))


## Manual steps after install
- System Settings > Startup Applications > Add polybar:
    /home/inkycap/.config/polybar/launch.sh
