# =============================================================================
# ~/.bashrc — candle-light shell config
# =============================================================================

# If not running interactively, bail
[[ $- != *i* ]] && return

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth          # ignore duplicates and lines starting with space
shopt -s histappend             # append, never overwrite

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------
shopt -s checkwinsize           # update LINES/COLUMNS after each command
shopt -s globstar               # ** glob
shopt -s cdspell                # forgive minor cd typos

# -----------------------------------------------------------------------------
# Starship prompt
# If starship isn't installed yet, fall back to a minimal candle-light prompt.
# -----------------------------------------------------------------------------
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    # Fallback: user@host:path (git branch) $
    _git_branch() {
        git branch 2>/dev/null | grep '^\*' | sed 's/\* //'
    }
    PS1='\[\e[38;2;200;149;90m\]\u\[\e[38;2;85;85;85m\]@\[\e[38;2;122;106;85m\]\h\[\e[38;2;85;85;85m\]:\[\e[38;2;232;224;208m\]\w\[\e[38;2;217;153;98m\]$(_git_branch | sed "s/\(.\+\)/ (\1)/")\[\e[38;2;85;85;85m\] \$ \[\e[0m\]'
fi

# -----------------------------------------------------------------------------
# fzf — fuzzy finder
# Ctrl+R for history, Ctrl+T for files, Alt+C for directories
# -----------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    eval "$(fzf --bash 2>/dev/null)" || source /usr/share/doc/fzf/examples/key-bindings.bash 2>/dev/null
    # Candle-light fzf colors
    export FZF_DEFAULT_OPTS="
        --color=bg:#0D0D0D,bg+:#1E1A14
        --color=fg:#F2F2F2,fg+:#F5EFE0
        --color=hl:#C8955A,hl+:#D99962
        --color=info:#7A6A55,prompt:#D99962,pointer:#D99962
        --color=marker:#C8955A,spinner:#7A6A55,header:#383838
        --border=rounded
        --height=40%
        --reverse
    "
    export FZF_CTRL_T_COMMAND='find . -type f -not -path "./.git/*" 2>/dev/null'
fi

# -----------------------------------------------------------------------------
# zoxide — smarter cd
# -----------------------------------------------------------------------------
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
    alias cd='z'                # replace cd with zoxide
fi

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias vi='vim'
alias v='vim'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# dotfiles shortcut
alias dots='cd ~/Projects/ferg-dots && vim .'

# -----------------------------------------------------------------------------
# Tool init
# -----------------------------------------------------------------------------
# bash-completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
