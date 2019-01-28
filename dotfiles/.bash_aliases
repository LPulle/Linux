## User specific aliases and functions
# sudo commands parse aliases
alias sudo='sudo '

# General
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias cd..='cd ..'
alias cd~='cd ~'
alias yum='sudo yum'
#alias git='sudo git'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto -n'
alias fgrep='fgrep --color=auto -n'
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias path='echo -e ${PATH//:/\\n}'
alias ping='ping -c 5'
alias fastping='ping -c 100 -s.2'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 5'
alias psmem10='ps auxf | sort -nr -k 5 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
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
# some ls aliases
alias ls='ls --color=auto'
alias ll='ls -alh'
alias llc='ls -AlhF --color=auto'
alias la='ls -A'
alias l='ls -CFlh'
alias lsd="ls -alF | grep /$"
alias l.='ls -d .* --color=auto'

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

# For fun
alias woo='Fortune'
# This will keep you sane when you're about to smash the keyboard again.
alias frak='fortune'
# get random BOFH excuse
function bofh() {
    telnet towel.blinkenlights.nl 666
}
