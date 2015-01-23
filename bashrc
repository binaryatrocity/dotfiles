# Add home-dir bin for random scripts etc
export PATH=$HOME/bin:$PATH

# Vi keybindings or bust
export EDITOR=vim
set -o vi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL='ignoreboth'
export HISTFILESIZE=2000000
export HISTIGNORE='&:ls:exit'
shopt -s histappend
set cmdhist

# shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# Get our git stuff (TODO: Add to dotfiles install.sh)
source ~/dotfiles/git-completion.sh
source ~/dotfiles/git-prompt.sh

force_color_prompt=yes

# Prompt colors
BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
RED='\[\033[0;31m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
BYELLOW='\[\033[1;33m'
YELLOW='\[\033[0;33m'
BMAGENTA='\[\033[1;35M'
MAGENTA='\[\033[0;35M'
BCYAN='\[\033[1;36m'
CYAN='\[\033[0;36m'
NORMAL='\[\033[00m\]'

# Prompt vars
TIME="\@"
HOST="\h"
USER="\u"
CWD="\w"
PUID="\$"
GIT="\$(__git_ps1)"


if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${BLUE}(${GREEN}${CWD}${BLUE}) ${NORMAL}${USER}@${HOST}${BRED}${GIT}${GREEN} ${PUID}${NORMAL} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;; *)
    ;; esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -X --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto' 
fi

# some more ls aliases
alias ll='ls -alF' 
alias la='ls -A' 
alias l='ls -CF'

#mah aliases, son
alias atr0phy='ssh br4n@binary.atr0phy.net'
alias cls='clear && ls -X --color=auto'

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
