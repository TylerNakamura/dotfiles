#! /bin/bash
#      __________
#     / ___  ___ \
#    / / @ \/ @ \ \
#    \ \___/\___/ /\
#     \____\/____/||
#     /     /\\\\\//
#    |     |\\\\\\
#     \      \\\\\\
#       \______/\\\\
#        _||_||_
# 
#
# tcn - created on 2019-09-16

##$$$$$$################# UPDATES ####################################

if [ $(whoami) = "root" ]
then
  apt update -y
else
  sudo apt update -y
fi

################### INSTALLING FAVORITE TOOLS #########################

favetools=(
  tcpdump,tcpdump
  nc,netcat
  telnet,telnet
  curl,curl
  dig,dnsutils
  gpg,gnupg
  ping,ping
  nmap,nmap
  netstat,net-tools
  ethtool, ethtool
)

# for every tool and package
for i in "${favetools[@]}"; do
  IFS="," read tool package <<< "${i}"
  echo "checking to see if ${tool} is installed from the ${package}..."

  which ${tool} >> /dev/null
  if [ $? -eq 0 ]
  then
    echo "${tool} is already installed"
  else
    echo "${tool} is not already installed, attempting installation..."
    if [ $(whoami) = "root" ]
    then
      apt install ${package} -y
    else
      sudo apt install ${package} -y
    fi
  fi
done

################## VI MODE SETTING IN BASH ###########################

# if vi mode isn't already in bashrc, then add into the bashrc
if grep -Fxq "set -o vi" ~/.bashrc
then
        printf "bashrc already has vi mode\n"
else
        # add vi mode to bash rc
        printf "\n#tcn - vi mode for bash\nset -o vi\n" >> ~/.bashrc
fi


################## GIT SETTINGS    ###########################
# if git is installed, add my git settings

which git >> /dev/null
if [ $? -eq 0 ]
 then
  echo "git is installed"
  git config --global set.upstream current
  git config --global set.editor vim
  git config --global user.name "Tyler Nakamura"
  git config --global user.email "me@tylernakamura.com"
 else
  echo "git is NOT installed"
fi


