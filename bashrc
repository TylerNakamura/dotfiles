
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

# TODO
# - a function that is a "check with user to make sure they really want to proceed"

# macOS to stop giving warnings upon using bash
# source: https://news.ycombinator.com/item?id=21317623&p=2
# TODO add a macos guard here
export BASH_SILENCE_DEPRECATION_WARNING=1

# sometimes mac is dumb and doesnt repeat keys
# source: https://www.idownloadblog.com/2015/01/14/how-to-enable-key-repeats-on-your-mac/
# TODO, add guard and mac check
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# can make an if statement with this: defaults read NSGlobalDomain ApplePressAndHoldEnabled

# vi mode
# the greatest feature of bash
set -o vi

# -a - all files, even hidden ones
# -l - long list
# -h - human readable
# -i - inode numbers
# -t - sort by time modified
alias ls="ls -lhit"

#----------------------------------------------------

# get dates of yesterday and tomorrow
# useful for scripting
alias tcntomorrow="date -v+1d +%Y-%m-%d"
alias tcnyesterday="date -v-1d +%Y-%m-%d"

#----------------------------------------------------

# macOS date command doesn't have iso output flag
# source: https://stackoverflow.com/questions/7216358/date-command-on-os-x-doesnt-have-iso-8601-i-option
alias tcnmacisodate="date -u +'%Y-%m-%dT%H:%M:%SZ'"

#----------------------------------------------------

# list block devices in a beautiful format
# source: https://www.digitalocean.com/community/tutorials/how-to-create-raid-arrays-with-mdadm-on-ubuntu-16-04
alias tcnlistblockdevices="lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT"

#----------------------------------------------------

# list all file extensions recursively, ordered, starting down from the current directory
alias tcnfileextensionsrecursive="find . -type f | sed 's/^.*\(\.[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]\).*$/\1/' | sort | uniq -c | sort -n | tac"

#----------------------------------------------------

# linux command to switch the left/right designations for monitors
# http://unix.stackexchange.com/questions/10589/how-can-i-swap-my-two-screens-left-to-right
alias tcnswitchmonitor="xrandr --output HDMI-0 --left-of DVI-I-0"

#----------------------------------------------------

# http://askubuntu.com/questions/370786/how-to-convert-avi-xvid-to-mkv-or-mp4-h264
# converts AVI video files to MP4
alias tcnavitomp4="avconv -i test.avi -c:v libx264 -c:a copy outputfile.mp4"

#----------------------------------------------------

# askubuntu.com/questions/39180/pdf-to-mobi-convertor
# converts PDF to mobi files
# TODO, create a function here and take in an argument
alias tcnconverttomobi="ebook-converter document.pdf .mobi"

#----------------------------------------------------

# converts CR2 files to JPGs
# This will output (not replace) the file with a new extension.
# foo.CR2 exported to foo.png
alias tcncr2tojpg="ufraw-batch --out-type jpg *.CR2"

#----------------------------------------------------

# Recursively remove empty directories
# source: https://unix.stackexchange.com/questions/46322/how-can-i-recursively-delete-empty-directories-in-my-home-directory
# most likely to work on Linux, not sure about macOS
alias tcnrprintemptydir="find . -type d -empty -print"

# TODO: DANGER, maybe add some safeguards here?
#alias tcnrdeleteemptydir="find . -type d -empty -delete"

#----------------------------------------------------

# source: https://stackoverflow.com/questions/1657017/how-to-squash-all-git-commits-into-one
# squashes the WHOLE current tree into one
# CAREFUL
alias tcngitsquashallcommitsintoone='git reset $(git commit-tree HEAD^{tree} -m "A new start")'

#----------------------------------------------------

alias tcnmacrenamescreenshots='rename "s/Screen\ Shot\ //" *.png'

# USAGE:
#
#   tyler$ tcngetfilebirthday myfile.txt
#   2020-03-16
#
# Prints out the earliest known date of any given file
# This one is special because it is cross platform (mac and linux)
# it also just defaults to iso8601 format (just date)
# it also makes assumptions about what the "creation date" is
# Linux FS does not store creation date, so taking the earliest of 3 dates:
# access/modify/read
function tcngetfilebirthday() {
	if [ "$(tcngetos)" == "linux" ]; then
		echo "you're on Linux! This code has not yet been written"
		return 1;
	elif [ "$(tcngetos)" == "macos" ]; then
		# there are several dates in which you can get the "date" of a file
		# this function will attempt all of them, and choose the earliest known date of the photo

		# list of all possible dates (will be sorted at the end)
		datelist=""

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

		# grab all of the exif dates that match "CreationDate"
		# will sort through all of them, but might as well add them all
		exifdates=$(mdls $1 | grep CreationDate | awk '{print $3}')
		# add to our list
		datelist="$datelist$exifdates\n"

		# need to use printf here because it will render the new lines instead of the literal \n
		# print the list, sort it, then just take the earliest one
		echo "HERE IT ISSSSSS"
		printf $mystring | sort | head -n 1
	fi
}
export -f tcngetfilebirthday

#----------------------------------------------------

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

#----------------------------------------------------

# k8s simple service
function tcnk8shelloworldservice() {
  kubectl create deployment hello-world-deployment --image=gcr.io/google-samples/hello-app:1.0
  kubectl expose deployment hello-world-deployment --type NodePort --port 80 --target-port 8080
}
export -f tcnk8shelloworldservice

#----------------------------------------------------

# tcntask
# shows the appropriate tasks based on the time
# source: https://stackoverflow.com/questions/3490032/how-to-check-if-today-is-a-weekend-in-bash
function tcntask() {
	# always synchronize
	task syn

	clear

	cal -3

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


#----------------------------------------------------

# k8s debugging pod
function tcnk8stestpod() {
  kubectl run -i --tty --rm TESTPOD --image=centos --restart=Never -- sh
}
export -f tcnk8stestpod

#----------------------------------------------------

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

#----------------------------------------------------

# tests for intermittent HTTP errors or slowness
# prints curl testing in CSV format for easy parsing
#
# USAGE:
#      user$: tcncurlloop google.com
#
# OUTPUT:
#      301, 0.067804, 2020-04-02T22:10:06Z
#      301, 0.038223, 2020-04-02T22:10:07Z
#      301, 0.041026, 2020-04-02T22:10:08Z
#
#      (status code), (total time), (iso timestamp)
#
function tcncurlloop(){
	while true
		do curl -w '%{http_code}, %{time_total}, ' $1 --connect-timeout 3 -o /dev/null --silent; date -u +"%Y-%m-%dT%H:%M:%SZ"
		sleep 1s;
	done
}
export -f tcncurlloop

#----------------------------------------------------

# curl with as much useful information as possible
alias tcninfocurl="
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

#----------------------------------------------------

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

#----------------------------------------------------

# make an attempt to get the video in an mp4 and in best quality.
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

#----------------------------------------------------

# TODO, docs and safeguards needed
# DANGER, this will actually touch your FS,
# it's currently not accepting dir input, only runs on . (see the $PWD flag below)
function tcnadddates() {
  for targetfile in $(find "$(pwd)" -type f)
  do
    basefile=$(basename $targetfile)
    filepath=$(dirname $targetfile)
    newfilename=$(tcngetfilebirthday $basefile)-$basefile
    mv "$filepath/$basefile" "$filepath/$newfilename"
    echo " mv $filepath/$basefile $filepath/$newfilename"
  done
}
export -f tcnadddates

#----------------------------------------------------

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
function tcnflattendirectory() {
  if [ ! $# -eq 1 ]
  then
    echo "Please specify one directory path as an argument"
    return
  fi

  # if the argument supplied is not a directory
  # exit the script
  if [ ! -d "$1" ]; then
    echo "$1 is not a directory!"
    return
  fi

  read -p "DANGER. YOU ARE ABOUT TO FLATTEN THE DIRECTORY $1 PERMANENTLY. IS THIS REALLY WHAT YOU WANT TO DO? [y, n] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # bring all files to the top
    find $1 -mindepth 2 -type f -exec mv -i '{}' $1 ';'

    # remove all empty directories remaining
    find $1 -type d -empty -delete
  fi
}
export -f tcnflattendirectory

#----------------------------------------------------

# TODO - format this better
# favorite wireshark filters
# dns queries with no responses:
#     dns && (dns.flags.response == 0) && ! dns.response_in
