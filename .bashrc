##########################################
# Edvinas Jurevicius aka zatan ~/.bashrc #
##########################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000
HISTFILESIZE=4000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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
    alias ls='ls -lh --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
###########
# ALIASES #
########### 
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -l'
# Show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'

alias ack='ACK_PAGER_COLOR="less -x4SRFX" /usr/bin/ack-grep --color-filename=yellow --color-lineno=green --color-match=red --ignore-dir=requirements --ignore-dir=migrations --ignore-dir=.git --ignore-dir=media  --ignore-dir=locale --ignore-dir=whoosh --ignore-dir=xapian --ignore-dir=static --ignore-dir=docs --ignore-file=is:requirements.txt --ignore-file=is:pylint.report --type-set=DUMB="*.pyc" --nobreak --noenv -i -Q'

# Password generator
alias passwdgen='dd if=/dev/random bs=16 count=1 2>/dev/null | base64 | sed 's/=//g''
# SpeedTest

alias speedtest='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

alias shell='./manage.py shell_plus --settings=settings.local'

alias collectstatic='./manage.py collectstatic --settings=settings.local'

# Alias to translate google
# https://github.com/soimort/google-translate-cli
alias tra="trans en:lt"

# Use cat with colors pyhton-pygmentize should be installed.
alias catc='pygmentize -g '

# Delete all pyc
alias removepyc='find . -name "*.pyc" -exec rm -rf {} \;'

# Run SimpleHttpServer
alias server='python -m SimpleHTTPServer 8070'

# Display sizes
alias duh='du -h|sort -hr'

# Switch to www-data user
alias www-data='sudo su - www-data'

# Switch to any user
alias suweb='sudo su - '

# Heroku backup 
alias heroku_backup='curl -o latest.dump `heroku pg:backups public-url`'

###########
# EXPORTS #
###########
# Exporting editor vim
export EDITOR=vim
# Virtualenvwrapper Home dir
export WORKON_HOME=/var/envs/
# Projects home 
export PROJECT_HOME=/var/www
# Grep options
export GREP_OPTIONS='--exclude-dir=.git --exclude-dir=node_modules --exclude-dir=logs --exclude-dir=xapian --exclude-dir=media --exclude-dir=static --exclude-dir=whoosh --exclude=*.pyc --exclude=*.swp'
# Virtualenvwrapper bin directory
export VIRTUALENVWRAPPER_HOOK_DIR=/var/envs/bin
# To use 256 colors
export TERM=xterm-256color

# Enable bash completion       
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

###########
# SOURCES #
###########
# Source to be able to user viritualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh > /dev/null 2>&1 || true

# To work with git display branch status for Ubuntu 12.04 or less
# /etc/bash_completion.d/git
source /etc/bash_completion.d/git-prompt

color_prompt=yes
GIT_PS1_SHOWDIRTYSTATE='1'
GIT_PS1_SHOWSTASHSTATE='1'
GIT_PS1_SHOWUNTRACKEDFILES='1'
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUPSTREAM="auto"

# Set PS1
HOSTNAME=$(hostname)
PS1='${debian_chroot:+($debian_chroot)}\[\033[1;32m\]\u@\[\033[1;36m\]\h \[\033[01;32m\]-> \[\033[0;37m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '
if [ $HOSTNAME != "zatan" ] && [ $HOSTNAME != "ed" ] && [ $HOSTNAME != "edvinas-Z97-HD3" ]; then
    # Bold for servers
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;31m\]\u@\h\[\033[01;32m\]:\[\033[0;37m\]\w\[\033[33m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '
fi

# Set title
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# Export display if it's not set.
if ! [ "$DISPLAY" ]
then
    export export DISPLAY=localhost:0.0
fi


# Function to open google-search from terminal with passed argument.
function chrome-search(){
 google-chrome http://www.google.co.uk/search?q="$1"
}

# Default django settings moduke
export DJANGO_SETTINGS_MODULE=''


function suweb(){
    sudo -u "$1" -i /home/edvinas/switcher.sh
}


function runserver(){
    if [ "$1" ]; then
        ./manage.py runserver $1
    else 
        ./manage.py runserver 127.0.0.1:8000
    fi

}

# Get backup from server
function get_backup(){
    ssh -C $1 sudo -u postgres pg_dump --no-owner $2 > "$2".dump
}


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
