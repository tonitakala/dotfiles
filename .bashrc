# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## Optimize directory searching
## https://github.com/junegunn/fzf?tab=readme-ov-file#using-the-finder

# Feed the output of fd into fzf
# fdfind --type f --strip-cwd-prefix | fzf

# Powershell alias
alias powershell='pwsh'

# Find projects faster
alias d='cd $(fdfind --type d --strip-cwd-prefix | fzf)'

# Fix xdg-open not being able to open Windows browser
# Might require: sudo apt install xdg-utils
# https://github.com/microsoft/WSL/issues/8892#issuecomment-1964338674
export BROWSER="/mnt/c/windows/system32/cmd.exe /c start" # add to ~/.profile to make permanent

# @rantalainen/node-powershell-handler
# remember to run `chmod +x askpass.sh`
export SSH_ASKPASS_OVERRIDE="$HOME/dotfiles/askpass.sh"

### START -  Always show git branch ###
parse_git_branch() {
  # Get current branch name (or exit silently if not in a git repo)
  local branch
  branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return

  # Try to find the upstream (origin/main, origin/feature-xyz, etc.)
  local upstream
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null) || {
    # No upstream configured: just show the branch name
    printf '%s' "$branch"
    return
  }

  # Count commits ahead/behind upstream
  local counts behind ahead
  counts=$(git rev-list --left-right --count "$upstream"...HEAD 2>/dev/null) || {
    printf '%s' "$branch"
    return
  }

  # Split "X<tab>Y" (or any whitespace) into behind and ahead
  read -r behind ahead <<<"$counts"

  # Safety defaults
  behind=${behind:-0}
  ahead=${ahead:-0}

  # Build output: branch [<behind>↓] [<ahead>↑]
  local out="$branch"
  if [ "$behind" -ne 0 ]; then
    out+=" ${behind}↓"
  fi
  if [ "$ahead" -ne 0 ]; then
    out+=" ${ahead}↑"
  fi

  printf '%s' "$out"
}

PS1='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[0m\]:\[\033[01;34m\]\w\[\033[0m\]$(branch=$(parse_git_branch); [ -n "$branch" ] && printf " \[\033[0;31m\](%s)\[\033[0m\]" "$branch")\$ '
### END - Always show git branch ###

# Load Angular CLI autocompletion.
# source <(ng completion script)

# This is slow to execute?
eval "$(zoxide init bash)"
