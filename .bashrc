# ~/.bashrc

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
test -s /etc/bash.bashrc && . /etc/bash.bashrc || true
export EDITOR=/usr/bin/vim

alias l='ls -la'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -lh'
#alias grep='grep -i'
alias df='df -h'
#alias ssh='ssh -Y'
alias pa='ps aux'
alias cs='CPWD=`pwd`;find $CPWD -regex ".*\.[c,h][pp|xx]*" > cscope.files; cscope -bRql; ctags -R'

alias q='exit'
alias r='screen -r'

test -s ~/.alias && . ~/.alias || true
test -s ~/bin/cdargs-bash.sh && . ~/bin/cdargs-bash.sh || true

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
PS1='\[\e[36;1m\][\h@\W]\[\e[0m\]\$'

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH:~/bin:/usr/local/mysql/bin
export PATH
alias ls='ls --color=auto'
LS_COLORS='no=00:fi=00:di=01;35:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.rar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
export LS_COLORS
export CVS_LOCATION=BEIJING

# git env
GIT_COMMITTER_NAME="Peng Tao";
GIT_COMMITTER_EMAIL="<bergwolf@gmail.com>";
export GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL

