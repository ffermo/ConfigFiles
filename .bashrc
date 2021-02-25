# Configuration for Bash Shell

# Personal aliases.
alias py='python'
alias run='./a.out'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -ahlN --time=ctime --color=auto --group-directories-first'
alias xtmux='export DISPLAY="`tmux show-env | sed -n 's/^DISPLAY=//p'`"'

# cd into directory by typing directory name.
shopt -s autocd

# Color support for ls and grep 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls -ahlN --color=always --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# How to handle bash command history.
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# Updates TMUX display variable.
# export DISPLAY="`tmux show-env | sed -n 's/^DISPLAY=//p'`"


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source ROS environment variables at launch if installed on system.
if [ -d "/opt/ros/melodic/" ]; then
	source /opt/ros/melodic/setup.bash
fi

# Checks to see if in Windows environment (WSL).
if grep -q icrosoft /proc/version; then
	export EXECIGNORE=\*.dll
	export PS1="\[\e[31m\]\u\[\e[m\]:\w\\$ "
	export LS_COLORS="di=1;31:ex=1;37:tw=30;41:ow=1;37;41"
	export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

	source /opt/ros/melodic/setup.bash

	# Source the ROS setup file for the EZRASSOR.
	source "/home/francis/ezrassor_ws/devel/setup.bash"
	
	# WSL aliases for quick nav.
	alias UCF='cd /mnt/f/Documents/UCF'
	alias ff='cd /mnt/f/'
	alias open='cmd.exe /C start'

# Otherwise, we SHOULD be in Linux environment.
else
	open() {
		xdg-open "$1" &>/home/francis/nohup.out
	}
	
	alias UCF='cd /home/francis/Francis/Documents/UCF'
fi

# Source the ROS setup file for the EZRASSOR, if it exists.
if [ -f "/home/francis/ezrassor_ws/devel/setup.bash" ]; then
  . "/home/francis/ezrassor_ws/devel/setup.bash"
fi
