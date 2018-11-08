export EDITOR=vim
set -o vi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# shopt -s checkwinsize
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
# Get our git stuff
source ~/code/dotfiles/git-completion.sh
source ~/code/dotfiles/git-prompt.sh

force_color_prompt=yes

# Prompt colors
BGREEN='\[\033[1;32m\]'
GREEN='\[\033[0;32m\]'
BRED='\[\033[1;31m\]'
BPURPLE='\e[1;36m'
PURPLE='\e[0;36m'
RED='\[\033[0;31m\]'
CYAN='\[\033[0;36m\]'
LCYAN='\[\033[1;36m\]'
BBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'
GREY='\[033[0;37m\]'
DGREY='\[033[1;30m\]'
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
    PS1="${BLUE}(${GREEN}${CWD}${BLUE}) ${NORMAL}${HOST}${BRED}${GIT}${NORMAL} [$?${NORMAL}]${GREEN} ${PUID}${NORMAL} "
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
    alias ls='ls -CFX --color=auto'
    #alias dir='dir --color=auto' alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto' 
fi

# some more ls aliases
alias ll='ls -alF' 
alias la='ls -A' 
alias l='ls -CF'

#mah aliases, son
alias atr0phy='ssh br4n@atr0phy.net'
alias at0rphy='ssh -L 9050:127.0.0.1:9050 br4n@atr0phy.net'
alias evoluent='xinput --set-button-map 14 3 1 1 4 5 7 8 9 0 10 11'
alias cls='clear && ls -X --color=auto'
alias notes="vim +VimwikiIndex"
alias tmpvim="vim /tmp/$(uuid)"
alias snip="scrot -s ~/Documents/screenshots/%b%d-%H:%M.png"

# Add an "alert" alias for long running commands. Use like so:
# sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# add this configuration to ~/.bashrc
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync

# if this is interactive shell, then bind hh to Ctrl-r
bind '"\C-r": "hh\n"'

export NVM_DIR="/home/brandon.cornejo/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm


# Clipboard jazz
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }  
# Copy SSH public key
alias cbssh="cbf ~/.ssh/id_rsa.pub"  
# Copy current working directory
alias cbwd="pwd | cb"  
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"  


# ASCII ART GOODNESS
echo -e "$(<~/.motd)"

# Search command history
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
