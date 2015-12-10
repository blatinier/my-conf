HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# Don't overwrite, append!
setopt APPEND_HISTORY

# Killer: share history between multiple shells
setopt SHARE_HISTORY

# Pretty    Obvious.  Right?
setopt HIST_REDUCE_BLANKS

setopt autocd extendedglob
unsetopt alwayslastprompt
bindkey -e
autoload -Uz compinit
compinit
autoload colors
colors
reset="$terminfo[sgr0]"
bold="$terminfo[bold]"
color_isok="%(?.%{$bold$fg[green]%}.%{$bold$fg[black]%})"
export PS1="%{$bold$fg[green]%}%n@%M%{$reset%}:%{$bold$fg[blue]%}%~%(!.#.$)%{$reset%} "
export PATH=/bin:/sbin:/usr/sbin:/usr/local/bin:~/bin:/opt/kde/bin/:$PATH
export WORKON_HOME=~/.venvs
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey '5D' emacs-backward-word
bindkey '5C' emacs-forward-word

# why would you type 'cd dir' if you could just type 'dir'?
setopt AUTO_CD

# Now we can pipe to multiple outputs!
setopt MULTIOS

# Spell check commands!  (Sometimes annoying)
setopt CORRECT

# This makes cd=pushd
setopt AUTO_PUSHD

# This will use named dirs when possible
setopt AUTO_NAME_DIRS

# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

# No more annoying pushd messages...
# setopt PUSHD_SILENT

# blank pushd goes to home
setopt PUSHD_TO_HOME

# this will ignore multiple directories for the stack.  Useful?  I dunno.
setopt PUSHD_IGNORE_DUPS

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=40
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
# End of lines configured by zsh-newuser-install

alias :q="exit"
alias ..="cd .."
alias cd..="cd .."
alias sl="ls"
alias l="ls"
alias s="ls"
alias ks="ls"
alias lks="ls"
alias kls="ls"
alias ms="ls"
alias lms="ls"
alias ls='ls --color'
alias ll='ls -l'
alias lla='ls -al'
alias llh='ls -hl'
alias llha='ls -ahl'
alias vi='vim'
alias cim="vim"
alias bim="vim"
alias vul="vim"
alias voù="vim"
alias cleanlatex='rm -f *.toc(N) *.aux(N) *.log(N)'
alias jh='hg'
alias jg='hg'
alias radioMoi="mplayer -cache 500 http://latinier.fr:8000"
alias gitlog="git log --oneline --decorate --graph --color"
export SVN_EDITOR=vim
export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc
alias gitka='LANG=C gitk --all &'      # gitk fuck yeah
alias tig='tig --all'
alias please='sudo $(fc -ln -1)'

export PYTHONPATH=src
source /usr/bin/virtualenvwrapper.sh
alias clean='find . -name "*.pyc" -delete && find . -name "*.orig" -delete'
alias swear='espeak -v french -a 500 -s 145'

# copy with a progress bar.
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
