## User specific aliases and functions
# sudo commands parse aliases
alias sudo='sudo '

# Change bash prompt. See the article
# http://www-106.ibm.com/developerwork.../l-tip-prompt/
export PS1='\d \@ \[\e[32;1m\]\u\[\e[34;1m\]@\[\e[36;1m\]\H \[\e[34;1m\]\w\[\e[32;1m\] $ \[\e[0m\]'

# General
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias cd..='cd ..'
alias cd~='cd ~'
#alias git='sudo git'
alias gitadd='checkShellFile ? git addsrcipt "$1" : && git add "$1"'
alias gitupdateall='find . -maxdepth 1 -type d -print -execdir git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto -n'
alias fgrep='fgrep --color=auto -n'
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias nano='nano -w'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps -aux | head -1 ; ps auxf | sort -nr -k 5'
alias psmem10='ps -aux | head -1 ; ps auxf | sort -nr -k 5 | head -10'
alias pscpu='ps -aux | head -1 ; ps auxf | sort -nr -k 3'
alias pscpu10='ps -aux | head -1 ; ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'
alias powershell='pwsh'
alias wget='wget -c'
alias csv='paste -d, -s'
alias untar='tar -xvf'
alias bc='bc -l'
alias diff='colordiff'
alias cx='chmod +x'
#alias myips="ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'"
# Clear the screen of your clutter
alias c="clear"
alias cl="clear;ls;pwd"
alias cls='clear'
# some ls aliases
alias ls='ls --color=auto'
alias ll='ls -alch'
alias llc='ls -AlhF --color=auto'
alias la='ls -A'
alias l='ls -CFlh'
alias lsd="ls -alF | grep /$"
alias l.='ls -d .* --color=auto'
alias lls='ls -lac'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Networking
alias ports='netstat -tulanp'
alias ipt='sudo /sbin/iptables'
#display all rules
alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'
alias firewall=iptlist
#alias dnstop='dnstop -l 5  eth1'
#alias vnstat='vnstat -i eth1'
#alias iftop='iftop -i eth1'
alias tcpdump='tcpdump -i eth1'
alias ethtool='ethtool eth1'

# crontab
alias crontabe='EDITOR=nano sudo crontab -e'
alias crontabl='sudo crontab -l'
alias restartcron='sudo systemctl restart crond.service'
alias startcron='sudo systemctl start crond.service'
alias stopcron='sudo systemctl stop crond.service'

# Upgrade/update system
##Ubuntu -apt
alias apt='sudo apt'
alias apt-fullup='sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y'
alias apt-install='sudo apt install'
alias apt-search='sudo apt-cache search'
alias apt-show='suddo apt-cache show'
alias apt-purge='sudo apt --purge remove'
alias apt-remove='sudo apt remove'
alias apt-up='sudo apt update -y && sudo apt upgrade -y'
alias apt-policy='LANG=C apt-cache policy'
##Centos -yum
alias yum='sudo yum'

# Functions
function mkcd() { mkdir $1;cd $1; }
function mkmvcd() { mkdir ${*: -1:1}; mv $*; cd ${*: -1:1}; }
function lookfor() {
  echo "grep -r \"$1\" ./"
  grep -r "$1" ./
#fgrep -rni
}
# Extract function for all archive types
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1    ;;
      *.tar.gz) tar xzf $1    ;;
      *.bz2)    bunzip2 $1    ;;
      *.rar)    rar x $1    ;;
      *.gz)   gunzip $1   ;;
      *.tar)    tar xf $1   ;;
      *.tbz2)   tar xjf $1    ;;
      *.tgz)    tar xzf $1    ;;
      *.zip)    unzip $1    ;;
      *.Z)    uncompress $1 ;;
      *)      echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# perform 'ls' after 'cd' if successful.
cdls() {
  builtin cd "$*"
  RESULT=$?
  if [ "$RESULT" -eq 0 ]; then
    ls
  fi
}

function checkShellFile(){
    return ${1: -3} == ".sh"
}

# Safety
alias rm='rm -Iv --preserve-root'
alias mv='mv -vi'
alias cp='cp -vi'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
#use trsh instead of rm to move file(s) to trash instead of rm
#make this symlink first ln -s /home/<username>/.local/share/Trash/ ~/.Trash
#note: case sensitive and the dot before Trash
alias trsh='mv --target-directory=`~/.local/share/Trash/files/`'

# Become system administrator
alias god='sudo -i'
alias root='sudo -i'

# Apache
alias startapache='sudo /etc/init.d/apache2 restart&'
alias stopapache='sudo apache2ctl stop'

# Use this alias to edit the bashrc 
# When you do it will reload ~/.bashrc on exit enabling any changes
# Change the editor if you want to use emacs/vi/ed instead of nano
alias rc="nano ~/.bashrc && source ~/.bashrc"
alias editalias='nano ~/.bash_aliases && source ~/.bash_aliases'
alias reload='source .bash_profile'

# Put minimize buttons on the right back in gnome
# You can use gnometweak but this is what it does
alias addminimizebuttons="gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close""

# DiskUsage
alias d='du -sh'
# List the 10 largest files in the current directory including sub directories
alias findhugefiles="find . -printf '%s %p\n' | sort -nr | head -10"
# This is GOLD for finding out what is taking so much space on your drives!
alias diskspace="du -S | sort -n -r |more"
# Show me the size (sorted) of only the folders in this directory
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
# Disk free in human terms
alias df='df -h'

# For fun
alias woo='Fortune'
# This will keep you sane when you're about to smash the keyboard again.
alias frak='fortune'
# get random BOFH excuse
function bofh() {
    telnet towel.blinkenlights.nl 666
}
