HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
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
export PATH=/usr/local/bin:/bin:/sbin:/usr/sbin:~/bin:/opt/kde/bin/:$PATH
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

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=40
zstyle ':completion:*' original false
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/benoit/.zshrc'

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
export EDITOR=vim
export PYTHONSTARTUP=~/.pythonrc
alias gitka='LANG=C gitk --all &'      # gitk fuck yeah
alias tig='tig --all'
alias please='sudo $(fc -ln -1)'

export PYTHONPATH=src
source /usr/bin/virtualenvwrapper.sh
#alias nosetests="nosetest3.4"
alias clean='find . -name "*.pyc" -delete && find . -name "*.orig" -delete'
alias swear='espeak -v french -a 500 -s 145'
