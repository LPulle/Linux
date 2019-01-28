# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# This is where you put your hand rolled scripts (remember to chmod them)
# PATH="$HOME/bin:$PATH"
# if running bash
if [ $(id -u) -eq 0 ];
then
    PS1='\[\e[1;36m\][\d \t \u@\h \w]\$\[\e[m\] '
else
    PS1='\[\e[1;32m\][\d \t \u@\h \w]\$\[\e[m\] '
fi

# Add date and time to bash history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Enable colour for grep
export GREP_OPTIONS='--color=auto'
