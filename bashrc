#!/bin/bash
# # # # # # # # # # # # # # # # # #
#                                  #
#  $$$$$$$$\  $$$$$$\  $$\   $$\   #
#  \__$$  __|$$  __$$\ $$$\  $$ |  #
#     $$ |   $$ /  \__|$$$$\ $$ |  #
#     $$ |   $$ |      $$ $$\$$ |  #
#     $$ |   $$ |      $$ \$$$$ |  #
#     $$ |   $$ |  $$\ $$ |\$$$ |  #
#     $$ |   \$$$$$$  |$$ | \$$ |  #
#     \__|    \______/ \__|  \__|  #
#                                  #
# # # # # # # # # # # # # # # # # #

# Purpose
# - Documentation
# - Toolset
# - Notepad

# Core Philosophies
# - portability and cross platform support is highest priority
# - keep each function independent, list dependencies if otherwise
# - readability > brevity

# Graphics Generator: http://patorjk.com/software/taag/#p=display&h=0&v=1&f=Standard

# TODO
# - a function that is a "check with user to make sure they really want to proceed"
# - a "filter for keyword" functionality in the tcndirmediaprep
# - disallow tcnmediaprep from being run outside of desktop or home directory (function tcnsafedirectory)
# - tcnnethostdiagnosticsgenerate
# - tcnnetinterpratediagnostics
# - extract tool (with tooltips to help remember)
# - bashrc to check itself to see if it is out of date with bashrc.tylernakamura.com
# - function to lowercase extensions (ie JPG to jpg)
# - image recognition to detect similar photos
# - tcndirmediaprep having problems with MOV files
# - tcndirmediaprep to separate photos and videos
# - tcnk8skillallpods
# - tcnman (ie tcnman tcndirmediaprep)
# - setup.tylernakamura.com should check for diskspace before installing stuff
# - DSSTORE killer (maybe AAE files too?)

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# ensure vim is default editor for programs
# source: https://unix.stackexchange.com/a/73486
export VISUAL=vim
export EDITOR="$VISUAL"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# vi mode
set -o vi

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# -a - all files, even hidden ones
# -l - long list
# -h - human readable
# -i - inode numbers
# -t - sort by time modified
alias ls="ls -lhit"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# get dates of yesterday and tomorrow
# useful for scripting
# these can't be static env variables because the shell will be open longer than a day
alias tcntomorrow="date -v+1d +%Y-%m-%d"
alias tcnyesterday="date -v-1d +%Y-%m-%d"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# list block devices in a beautiful format
# source: https://www.digitalocean.com/community/tutorials/how-to-create-raid-arrays-with-mdadm-on-ubuntu-16-04
alias tcnlistblockdevices="lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# linux command to switch the left/right designations for monitors
# http://unix.stackexchange.com/questions/10589/how-can-i-swap-my-two-screens-left-to-right
alias tcnswitchmonitor="xrandr --output HDMI-0 --left-of DVI-I-0"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# http://askubuntu.com/questions/370786/how-to-convert-avi-xvid-to-mkv-or-mp4-h264
# converts AVI video files to MP4
alias tcnavitomp4="avconv -i test.avi -c:v libx264 -c:a copy outputfile.mp4"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# askubuntu.com/questions/39180/pdf-to-mobi-convertor
# converts PDF to mobi files
# TODO, create a function here and take in an argument
alias tcnconverttomobi="ebook-converter document.pdf .mobi"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# converts CR2 files to JPGs
# This will output (not replace) the file with a new extension.
# foo.CR2 exported to foo.png
alias tcncr2tojpg="ufraw-batch --out-type jpg *.CR2"

function tcnsource() {
	#TODO, make this an env variable saved at the top
   source ~/dev/dotfiles/bashrc
   echo "bashrc reloaded"
}
export -f tcnsource

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# clean up OS things
function tcncleanup() {
  # if downloads and desktop directories exist, move everything from downloads to the desktop
  # downloads folders are dumb and stuffs accumlates too much
  [ -d ~/Downloads ] && [ -d ~/Desktop ] && mv ~/Downloads/* ~/Desktop/

  # if bash history exists, delete it
  [ -f ~/.bash_history ] && rm ~/.bash_history

  # possible ideas
  # if trash (folder) exists, delete everything inside of it
  # not sure how to do this one yet
}
export -f tcncleanup

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# tcntask
# shows the appropriate tasks based on the time
# source: https://stackoverflow.com/questions/3490032/how-to-check-if-today-is-a-weekend-in-bash
function tcntask() {
	# always synchronize
	task syn

	clear

	# print monthly productivity chart
	task ghistory.monthly

	# print 3 months of the calendar
	cal -3
		
	# check started tasks
	task active > /dev/null 2>&1
	# if there are tasks started, print that
	if [ $? -eq 0 ]
	then
		task active
  		return 0
	fi

	# check overdue tasks
	task overdue > /dev/null 2>&1
	# if there is stuff overdue, print that
	if [ $? -eq 0 ]
	then
		task overdue
  		return 0
	fi

	# TODO need to be fixed!
	# if it's the weekend, don't show work tasks
	if [[ $(date +%u) -gt 5 ]] ; then
	echo
		echo "-=-=-=-=-=-=-=-=-=-=-=-=-=HOME TASKS-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
		task next
	# if its outside of working(ish) hours (8am - 6pm), don't show work tasks
	# the sed will strip off leading zeroes
	elif [[ $(date +%H | sed 's/^0*//') -gt 7 && $(date +%H | sed 's/^0*//') -lt 18 ]] ;  then
		echo
		echo "-=-=-=-=-=-=-=-=-=-=-=-=-=WORK TASKS-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
		task next
	else
		echo
		echo "-=-=-=-=-=-=-=-=-=-=-=-=-=HOME TASKS-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
		task next
	fi
}
export -f tcntask


#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# uses `uname` to try to determine the OS
#
# USAGE:
#
#   tyler$ tcngetos
#   macos
#
function tcngetos() {
	if [ "$(uname)" == "Darwin" ]; then
		echo "macos"
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		echo "linux"
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		echo "ming32"
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
		echo "ming64"
	fi
}
export -f tcngetos

# source: https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c
# TODO/WARNING
# cannot handle files with spaces in names!!!
function tcnextract()
{
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Generate a pseudo UUID in bash
# source: https://serverfault.com/a/597626
function tcnuuid()
{
    local N B T

    for (( N=0; N < 16; ++N ))
    do
        B=$(( $RANDOM%255 ))

        if (( N == 6 ))
        then
            printf '4%x' $(( B%15 ))
        elif (( N == 8 ))
        then
            local C='89ab'
            printf '%c%x' ${C:$(( $RANDOM%${#C} )):1} $(( B%15 ))
        else
            printf '%02x' $B
        fi

        for T in 3 5 7 9
        do
            if (( T == N ))
            then
                printf '-'
                break
            fi
        done
    done

    echo
}
export -f tcnuuid

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#        ,--./,-.                                 
#       / #      \            _ __ ___     __ _    ___  
#      |          |          | '_ ` _ \   / _` |  / __|
#       \        /           | | | | | | | (_| | | (__       macOS Specific Settings
#        `._,._,'            |_| |_| |_|  \__,_|  \___|
#
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
if [ "$(uname)" == "Darwin" ]; then
    # macOS to stop giving warnings upon using bash (I don't want to use zsh!)
	# source: https://news.ycombinator.com/item?id=21317623&p=2
	if [ "$BASH_SILENCE_DEPRECATION_WARNING" != 1 ]; then
		export BASH_SILENCE_DEPRECATION_WARNING=1
	fi

	# sometimes macOS is dumb and does not repeat keys
	# source: https://www.idownloadblog.com/2015/01/14/how-to-enable-key-repeats-on-your-mac/
	# if the setting is not correct, fix it
	if [ "$(defaults read NSGlobalDomain ApplePressAndHoldEnabled)" = "1" ]; then
		echo "Disabling NSGlobalDomain ApplePressAndHoldEnabled."
		defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
	fi

	# macOS `date` command doesn't have iso output flag
	# source: https://stackoverflow.com/questions/7216358/date-command-on-os-x-doesnt-have-iso-8601-i-option
	alias tcnmacisodate="date -u +'%Y-%m-%dT%H:%M:%SZ'"

	alias tcnmacrenamescreenshots='rename "s/Screen\ Shot\ //" *.png'

	echo "macOS settings loaded"
fi

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                                 __   _   _        
#                                / _| (_) | |   ___ 
#                               | |_  | | | |  / _ \
#                               |  _| | | | | |  __/          File Manipulation
#                               |_|   |_| |_|  \___|
#                     
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
# USAGE:
#
#   tyler$ tcnfilegetbirthday myfile.txt
#   2020-03-16
#
# Prints out the earliest known date of any given file
# This one is special because it is cross platform (mac and linux)
# it also just defaults to iso8601 format (just date)
# it also makes assumptions about what the "creation date" is
# Linux FS does not store creation date, so taking the earliest of 3 dates:
# access/modify/read
function tcnfilegetbirthday() {
	if [ "$(tcngetos)" == "linux" ]; then
		echo "you're on Linux! This code has not yet been written"
		return 1;
	elif [ "$(tcngetos)" == "macos" ]; then
		# there are several dates in which you can get the "date" of a file
		# this function will attempt all of them, and choose the earliest known date of the photo

		# list of all possible dates (will be sorted at the end)
		datelist=""

		# FILESYSTEM DATA SOURCE

		# macos file system date
		getfileinfod=$(GetFileInfo -d $1 | cut -f 1 -d " ")
		# year
		yeard=$(echo $getfileinfod | cut -f 3 -d "/")
		# month
		monthd=$(echo $getfileinfod | cut -f 1 -d "/")
		# day
		dayd=$(echo $getfileinfod | cut -f 2 -d "/")
		dated="$yeard-$monthd-$dayd"
		# add this known date to the list
		datelist="$dated\n"

		# macos file system modification date
		getfileinfom=$(GetFileInfo -m $1 | cut -f 1 -d " ")
		# year
		yearm=$(echo $getfileinfom | cut -f 3 -d "/")
		# month
		monthm=$(echo $getfileinfom | cut -f 1 -d "/")
		# day
		daym=$(echo $getfileinfom | cut -f 2 -d "/")
		datem="$yearm-$monthm-$daym"
		# also add this known date to the list
		datelist="$datelist$datem\n"

		# FILE NAME DATA SOURCE
		#TODO make this an optional feature (maybe with a flag?)
		#TODO add other possible formats (slashes and dots could also be used)
		# search for an iso date in the name of the file
		# ie 2020-09-20cat.png would be 2020-09-20
		grepoutput=$(echo $1 | grep -o '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
		# if grep output was found from the filename
		if [ $? -eq 0 ]
		then
			# append to list of possible dates
			datelist="$datelist$grepoutput\n"
		fi

		# EXIF DATA SOURCE
		# grab all of the exif dates that match "CreationDate"
		# will sort through all of them, but might as well add them all
		exifdates=$(mdls $1 | grep CreationDate | awk '{print $3}')
		# append to list of possible dates
		datelist="$datelist$exifdates\n"

		# need to use printf here because it will render the new lines instead of the literal \n
		# print the list, sort it, then just take the earliest one
		printf "$datelist" | sort | head -n 1
	fi
}
export -f tcnfilegetbirthday

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                               _       ___        
#                              | | __  ( _ )   ___ 
#                              | |/ /  / _ \  / __|
#                              |   <  | (_) | \__ \          Kubernetes Tools
#                              |_|\_\  \___/  |___/
#
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# k8s simple service
function tcnk8shelloworldservice() {
  kubectl create deployment hello-world-deployment --image=gcr.io/google-samples/hello-app:1.0
  kubectl expose deployment hello-world-deployment --type NodePort --port 80 --target-port 8080
}
export -f tcnk8shelloworldservice

# k8s debugging pod
function tcnk8stestpod() {
  kubectl run -i --tty --rm TESTPOD --image=centos --restart=Never -- sh
}
export -f tcnk8stestpod

# k8s dns hammer
# source: https://github.com/TylerNakamura/dns-hammer
function tcnk8sdeploydnshammer() {
  kubectl create deployment dns-hammer --image=gcr.io/tyrionlannister-237214/dns-hammer
}
export -f tcnk8sdeploydnshammer

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                                 __ _    ___   _ __  
#                                / _` |  / __| | '_ \ 
#                               | (_| | | (__  | |_) |       GCP Tools
#                                \__, |  \___| | .__/ 
#                                |___/         |_|    
#                                 
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# GCP web server
# Creates a functioning web server in us-central1-a (for now)
# I would like it to start a Linux server serving both 80 and 443
# it should return the hostname in the /
# TODO currently only starts a http server, need to get a self signed cert going here
function tcngcpwebserver() {
    VMNAME=`date +'tcn-webserver-%F-%k-%M-%S'`

    # find possible subnets and pick a random one
    # worldy zones tend to have resource contraints, just isolating to us central for now
    SUBNETOUTPUT=`gcloud compute networks subnets list | tail -n +2 | grep us-central | sort -R | head -n 1`

    # just go to zone a
    ZONE=`echo $SUBNETOUTPUT | tr -s ' ' | cut -f 2 -d " "`-a

    SUBNET=`echo $SUBNETOUTPUT | tr -s ' ' | cut -f 1 -d " "`

    gcloud compute instances create $VMNAME \
        --zone=$ZONE \
        --image-family=debian-9 \
        --image-project=debian-cloud \
        --subnet=$SUBNET \
        --metadata=startup-script='#! /bin/bash
    apt-get update
    apt-get install apache2 -y
    a2ensite default-ssl
    a2enmod ssl
    vm_hostname="$(curl -H "Metadata-Flavor:Google" \
    http://169.254.169.254/computeMetadata/v1/instance/name)"
    echo "Page served from: $vm_hostname" | \
    tee /var/www/html/index.html
    systemctl restart apache2'
}
export -f tcngcpwebserver

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                                       _             _                 _   _ 
#               _   _    ___    _   _  | |_   _   _  | |__    ___    __| | | |
#              | | | |  / _ \  | | | | | __| | | | | | '_ \  / _ \  / _` | | |
#              | |_| | | (_) | | |_| | | |_  | |_| | | |_) ||  __/ | (_| | | |   youtube-dl
#               \__, |  \___/   \__,_|  \__|  \__,_| |_.__/  \___|  \__,_| |_|
#               |___/                                                          
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# make an attempt to get the video in an mp4 and in best quality
# If that fails, fall back to whatever the default is
function tcnyoutubedl() {
  # attempt to download it in my preferred format
  youtube-dl -f \"bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best/mp4\" $1
  # if that fails, just do whatever the default is
  RESULT=$?
  if [ ! $RESULT -eq 0 ]; then
    echo "first attempt with desired format failed, falling back to standard youtube-dl"
    youtube-dl $1
  fi
}
export -f tcnyoutubedl

# designated command for downloading music from youtube
# source: https://askubuntu.com/questions/634584/how-to-download-youtube-videos-as-a-best-quality-audio-mp3-using-youtube-dl
alias tcnyoutubedlmusic='youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0'

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                                       _   _   
#                                __ _  (_) | |_ 
#                               / _` | | | | __|
#                              | (_| | | | | |_              git Tools
#                               \__, | |_|  \__|
#                               |___/           
#
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

function tcngitpush() {
	git add .
	git commit
	git push origin master
}
export -f tcngitpush

# source: https://stackoverflow.com/questions/1657017/how-to-squash-all-git-commits-into-one
# squashes the WHOLE current tree into one
# CAREFUL
alias tcngitsquashallcommitsintoone='git reset $(git commit-tree HEAD^{tree} -m "A new start")'

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#
#                              _ __     ___  | |_ 
#                             | '_ \   / _ \ | __|
#                             | | | | |  __/ | |_            Networking Tools
#                             |_| |_|  \___|  \__|
#
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# tests for intermittent HTTP errors or slowness
# prints curl testing in CSV format for easy parsing
#
# USAGE:
#      user$: tcnnetcurlloop google.com
#
# OUTPUT:
#      301, 0.067804, 2020-04-02T22:10:06Z
#      301, 0.038223, 2020-04-02T22:10:07Z
#      301, 0.041026, 2020-04-02T22:10:08Z
#
#      (status code), (total time), (iso timestamp)
#
function tcnnetcurlloop(){
	while true
		do curl -w '%{http_code}, %{time_total}, ' $1 --connect-timeout 3 -o /dev/null --silent; date -u +"%Y-%m-%dT%H:%M:%SZ"
		sleep 1s;
	done
}
export -f tcnnetcurlloop

# curl with as much useful information as possible
alias tcnnetcurl="
curl -o /dev/null -vs -w \
'
time_appconnect:    %{time_appconnect}s (start until the SSL/SSH/etc connect/handshake to the remote host was completed)
time_connect:       %{time_connect}s (start until the TCP connect to the remote host (or proxy) was completed)
time_namelookup:    %{time_namelookup}s (start until the name resolving was completed)
time_pretransfer:   %{time_pretransfer}s (start until the file transfer was just about to begin)
time_redirect:      %{time_redirect}s (all redirection steps before the final transaction was started)
time_starttransfer: %{time_starttransfer}s (TTFB)
time_total:         %{time_total}s
content_type:       %{content_type}
http_code:          %{http_code}
http_version:       %{http_version}
local_ip:           %{local_ip}
local_port:         %{local_port}
remote_ip:          %{remote_ip}
remote_port:        %{remote_port}
size_download:      %{size_download} bytes
size_header:        %{size_header} bytes
size_request:       %{size_request} bytes
size_upload:        %{size_upload} bytes
speed_download:     %{speed_download} bytes per second
speed_upload:       %{speed_upload} bytes per second
' \
"

#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~
#                                  _   _        
#                               __| | (_)  _ __ 
#                              / _` | | | | '__|
#                             | (_| | | | | |                Directory Tools
#                              \__,_| |_| |_|   
#
#~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~

# list all file extensions recursively, ordered, starting down from the current directory
alias tcndirfileextensionsrecursive="find . -type f | sed 's/^.*\(\.[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]\).*$/\1/' | sort | uniq -c | sort -n | tac"

# Recursively remove empty directories
# source: https://unix.stackexchange.com/questions/46322/how-can-i-recursively-delete-empty-directories-in-my-home-directory
# most likely to work on Linux, not sure about macOS
alias tcndirprintempty="find . -type d -empty -print"

# TODO: DANGER, maybe add some safeguards here?
#alias tcnrdeleteemptydir="find . -type d -empty -delete"

# TODO, docs and safeguards needed
# DANGER, this will actually touch your FS,
# it's currently not accepting dir input, only runs on . (see the $PWD flag below)
function tcndirprependiso() {
  # default $IFS includes spaces as delimitters, which is bugged for files with multi word
  # save for laterIFS=$'\n'; for targetfile in $(find "$(pwd)" -type f)
  for targetfile in ./*
  do
    if [ -f $targetfile ]; then
      basefile=$(basename $targetfile)
      filepath=$(dirname $targetfile)
      newfilename=$(tcnfilegetbirthday $basefile)-$basefile
      mv "$filepath/$basefile" "$filepath/$newfilename"
      echo " mv $filepath/$basefile $filepath/$newfilename"
    fi
  done
}

# takes a directory tree and flattens it
#/dir1
#   /dir2
#      |
#       --- file1
#      |
#       --- file2
#
#/dir1
#   |
#    --- file1
#   |
#   --- file2
#
# source: https://unix.stackexchange.com/questions/52814/flattening-a-nested-directory/52816#
function tcndirflatten() {
  # bring all files to the top
  find . -mindepth 2 -type f -exec mv -i '{}' . ';'

  # remove all empty directories remaining
  find . -type d -empty -delete
}

# WARNING: spaces with file names will bug this
function tcndirprependmd5() {
  for f in ./*
  do
    if [ -f $f ]; then
      basefile=$(basename $f)
      filepath=$(dirname $f)
      hash=$(md5 -q $f)

      echo "mv $filepath/$basefile $filepath/$hash-$basefile"

      mv "$filepath/$basefile" "$filepath/$hash-$basefile"
  fi
  done
}

# WARNING: spaces with file names will bug this
# depends on tcnuuid
function tcndirprependuuid() {
  for f in ./*
  do
    if [ -f $f ]; then
      basefile=$(basename $f)
      filepath=$(dirname $f)
	  # don't want the full UUID here, 5 characters is fine
      uuid=$(tcnuuid | head -c 5)

      echo "mv $filepath/$basefile $filepath/$uuid-$basefile"

      mv "$filepath/$basefile" "$filepath/$uuid-$basefile"
  fi
  done
}

# source: https://vitux.com/how-to-replace-spaces-in-filenames-with-underscores-on-the-linux-shell/
function tcndirspacetodash() {
  for f in ./*
  do
    new="${f// /-}"
    if [ "$new" != "$f" ]
    then
      # if that file name already exists
      if [ -e "$new" ]
      then
        echo not renaming \""$f"\" because \""$new"\" already exists
        echo "potential for data loss!"
        return 1
      else
        echo "mv $f $new"
        mv "$f" "$new"
    fi
  fi
done
}

function tcndirmediaprep() {
   tcndirflatten
   tcndirspacetodash
   tcndirprependuuid
   tcndirprependmd5
   tcndirprependiso
}
export -f tcndirmediaprep