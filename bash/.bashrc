# =============================================================================
# ~/.bashrc — candle-light shell config
# =============================================================================

case $- in
    *i*) ;;
      *) return;;
esac

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------
HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend

# -----------------------------------------------------------------------------
# Shell options
# -----------------------------------------------------------------------------
shopt -s checkwinsize
shopt -s globstar
shopt -s cdspell

# -----------------------------------------------------------------------------
# Debian chroot
# -----------------------------------------------------------------------------
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------------------------------------------------------
# LS_COLORS — candle-light mapping
#
# Philosophy: near-monochrome. Only two things get warm colour:
#   directories → bone  (bright, not blue)
#   executables → amber (the flame — something you can run)
#   archives    → ember (contained fire)
#   symlinks    → wick  (dim cord)
#   everything else → cool grey shades
#
#   bone      ≈ 254  #E8E0D0
#   amber     ≈ 214  #D99962
#   wax       ≈ 173  #C8955A
#   wick      ≈ 243  #7A6A55
#   cool grey ≈ 245  #8C8C8C
#   dark grey ≈ 237  #383838
#   ember red ≈ 130  #6B2A1A
# -----------------------------------------------------------------------------
export LS_COLORS="\
rs=0:\
di=01;38;5;254:\
ln=38;5;243:\
mh=00:\
pi=38;5;245:\
so=38;5;173:\
do=38;5;173:\
bd=38;5;237;01:\
cd=38;5;237;01:\
or=38;5;130:\
mi=38;5;237:\
su=38;5;214;01:\
sg=38;5;214:\
ca=00:\
tw=38;5;254:\
ow=38;5;254:\
st=38;5;245:\
ex=01;38;5;214:\
*.tar=38;5;130:*.tgz=38;5;130:*.arc=38;5;130:*.arj=38;5;130:\
*.taz=38;5;130:*.lha=38;5;130:*.lz4=38;5;130:*.lzh=38;5;130:\
*.lzma=38;5;130:*.tlz=38;5;130:*.txz=38;5;130:*.tzo=38;5;130:\
*.t7z=38;5;130:*.zip=38;5;130:*.z=38;5;130:*.dz=38;5;130:\
*.gz=38;5;130:*.lrz=38;5;130:*.lz=38;5;130:*.lzo=38;5;130:\
*.xz=38;5;130:*.zst=38;5;130:*.tzst=38;5;130:*.bz2=38;5;130:\
*.bz=38;5;130:*.tbz=38;5;130:*.tbz2=38;5;130:*.tz=38;5;130:\
*.deb=38;5;130:*.rpm=38;5;130:*.jar=38;5;130:*.war=38;5;130:\
*.ear=38;5;130:*.sar=38;5;130:*.rar=38;5;130:*.ace=38;5;130:\
*.zoo=38;5;130:*.cpio=38;5;130:*.7z=38;5;130:*.rz=38;5;130:\
*.cab=38;5;130:*.wim=38;5;130:*.swm=38;5;130:*.dwm=38;5;130:\
*.esd=38;5;130:\
*.avif=38;5;245:*.jpg=38;5;245:*.jpeg=38;5;245:*.mjpg=38;5;245:\
*.mjpeg=38;5;245:*.gif=38;5;245:*.bmp=38;5;245:*.pbm=38;5;245:\
*.pgm=38;5;245:*.ppm=38;5;245:*.tga=38;5;245:*.xbm=38;5;245:\
*.xpm=38;5;245:*.tif=38;5;245:*.tiff=38;5;245:*.png=38;5;245:\
*.svg=38;5;245:*.svgz=38;5;245:*.mng=38;5;245:*.pcx=38;5;245:\
*.mov=38;5;245:*.mpg=38;5;245:*.mpeg=38;5;245:*.m2v=38;5;245:\
*.mkv=38;5;245:*.webm=38;5;245:*.webp=38;5;245:*.ogm=38;5;245:\
*.mp4=38;5;245:*.m4v=38;5;245:*.mp4v=38;5;245:*.vob=38;5;245:\
*.qt=38;5;245:*.nuv=38;5;245:*.wmv=38;5;245:*.asf=38;5;245:\
*.rm=38;5;245:*.rmvb=38;5;245:*.flc=38;5;245:*.avi=38;5;245:\
*.fli=38;5;245:*.flv=38;5;245:*.gl=38;5;245:*.dl=38;5;245:\
*.xcf=38;5;245:*.xwd=38;5;245:*.yuv=38;5;245:*.cgm=38;5;245:\
*.emf=38;5;245:*.ogv=38;5;245:*.ogx=38;5;245:\
*.aac=38;5;243:*.au=38;5;243:*.flac=38;5;243:*.m4a=38;5;243:\
*.mid=38;5;243:*.midi=38;5;243:*.mka=38;5;243:*.mp3=38;5;243:\
*.mpc=38;5;243:*.ogg=38;5;243:*.ra=38;5;243:*.wav=38;5;243:\
*.oga=38;5;243:*.opus=38;5;243:*.spx=38;5;243:*.xspf=38;5;243:\
*~=38;5;237:*#=38;5;237:*.bak=38;5;237:*.tmp=38;5;237:\
*.swp=38;5;237:*.orig=38;5;237:*.old=38;5;237:*.part=38;5;237:\
*.pyc=38;5;237:*.pyo=38;5;237:*.class=38;5;237:\
"

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
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
alias dots='cd ~/Projects/ferg-dots && vim .'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# -----------------------------------------------------------------------------
# bash-completion
# -----------------------------------------------------------------------------
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# -----------------------------------------------------------------------------
# Cargo (Rust)
# -----------------------------------------------------------------------------
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# -----------------------------------------------------------------------------
# conda
# -----------------------------------------------------------------------------
__conda_setup="$('/home/inkycap/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/inkycap/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/inkycap/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/inkycap/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# -----------------------------------------------------------------------------
# nvm
# -----------------------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# -----------------------------------------------------------------------------
# fzf — fuzzy finder (Ctrl+R history, Ctrl+T files)
# -----------------------------------------------------------------------------
if command -v fzf &>/dev/null; then
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash || \
        source /usr/share/doc/fzf/examples/key-bindings.bash 2>/dev/null
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
# zoxide — smart cd
# -----------------------------------------------------------------------------
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
    alias cd='z'
fi

# -----------------------------------------------------------------------------
# Starship prompt
# Falls back to a minimal candle-light PS1 if starship isn't installed.
# -----------------------------------------------------------------------------
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
else
    _git_branch() { git branch 2>/dev/null | grep '^\*' | sed 's/\* //'; }
    PS1="${debian_chroot:+($debian_chroot)}"
    PS1+='\[\033[38;2;200;149;90m\]\u@\h\[\033[0m\]'
    PS1+='\[\033[38;2;122;106;85m\]:\[\033[0m\]'
    PS1+='\[\033[38;2;232;224;208m\]\w\[\033[0m\]'
    PS1+='\[\033[38;2;217;153;98m\]$(_git_branch | sed "s/\(.\+\)/ (\1)/")\[\033[0m\]'
    PS1+='\[\033[38;2;85;85;85m\] \$ \[\033[0m\]'
    export PS1
fi
