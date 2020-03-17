
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

set -o vi

# macOS to stop giving warnings upon using bash
# source: https://news.ycombinator.com/item?id=21317623&p=2
export BASH_SILENCE_DEPRECATION_WARNING=1

#----------------------------------------------------

# DOC FORMAT (Use for below functions)

# myfunction()
# DESCRIPTION:
# USAGE:
# SOURCES:

#----------------------------------------------------

# USAGE:
#
#   tyler$ tcngetfilebirthday myfile.txt
#   2020-03-16
#
# This one is special because it is cross platform (mac and linux)
# it also just defaults to iso8601 format (just date)
# it also makes assumptions about what the "creation date" is
# Linux FS does not store creation date, so taking the earliest of 3 dates:
# access/modify/read
function tcngetfilebirthday() {
	if [ "$(tcngetos)" == "linux" ]; then
		echo "you're on Linux! This code has not yet been written"
		exit 1;
	elif [ "$(tcngetos)" == "macos" ]; then
		getfileinfod=$(GetFileInfo -d $1 | cut -f 1 -d " ")

		# year
		yearf=$(echo $getfileinfod | cut -f 3 -d "/")
		# month
		monthf=$(echo $getfileinfod | cut -f 1 -d "/")
		# day
		dayf=$(echo $getfileinfod | cut -f 2 -d "/")

		echo "$yearf-$monthf-$dayf"
	fi
}
export -f tcngetfilebirthday

#----------------------------------------------------

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

# k8s debugging pod
function tcnk8stestpod() {
  kubectl run -i --tty --rm TESTPOD --image=centos --restart=Never -- sh
}
export -f tcnk8stestpod

#----------------------------------------------------

# clean up OS things
function tcncleanup() {
  # if downloads and desktop directories exist, move everything from downloads to the desktop
  [ -d ~/Downloads ] && [ -d ~/Desktop ] && mv ~/Downloads/* ~/Desktop/

  # if bash history exists, delete it
  [ -f ~/.bash_history ] && rm ~/.bash_history

  #possible ideas
  # if trash exists (macos), delete everything inside of it
}
export -f tcncleanup

#----------------------------------------------------

# curl with statistics and info
alias tcninfocurl="
curl -o /dev/null -Lvs -w \
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
# still a WIP
# I would like it to start a Linux server serving both 80 and 443
# it should return the hostname in the /
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

# list block devices
# source: https://www.digitalocean.com/community/tutorials/how-to-create-raid-arrays-with-mdadm-on-ubuntu-16-04
alias tcnlistblockdevices="lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT"

#----------------------------------------------------

# list all file extensions recursively, ordered, starting down from the current directory
alias tcnfileextensionsrecursive="find . -type f | sed 's/^.*\(\.[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]\).*$/\1/' | sort | uniq -c | sort -n | tac"

#----------------------------------------------------

# http://unix.stackexchange.com/questions/10589/how-can-i-swap-my-two-screens-left-to-right
alias tcnswitchmonitor="xrandr --output HDMI-0 --left-of DVI-I-0"

#----------------------------------------------------

# http://askubuntu.com/questions/370786/how-to-convert-avi-xvid-to-mkv-or-mp4-h264
alias tcnavitomp4="avconv -i test.avi -c:v libx264 -c:a copy outputfile.mp4"

#----------------------------------------------------

# askubuntu.com/questions/39180/pdf-to-mobi-convertor
alias tcnconverttomobi="ebook-converter document.pdf .mobi"

#----------------------------------------------------

# This will output (not replace) the file with a new extension.
# foo.CR2 exported to foo.png
alias tcncr2tojpg="ufraw-batch --out-type jpg *.CR2"

#----------------------------------------------------

# Recursively remove empty directories
# source: https://unix.stackexchange.com/questions/46322/how-can-i-recursively-delete-empty-directories-in-my-home-directory
# most likely to work on Linux, not sure about macOS
alias tcnrprintemptydir="find . -type d -empty -print"
alias tcnrdeleteemptydir="find . -type d -empty -delete"

#----------------------------------------------------

# make an attempt to get the video in an mp4 in best quality. If that fails, fall back to whatever the default is

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

# source: https://askubuntu.com/questions/634584/how-to-download-youtube-videos-as-a-best-quality-audio-mp3-using-youtube-dl
alias tcnyoutubedlmusic='youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0'

#----------------------------------------------------

# TODO, docs needed
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

# source: https://stackoverflow.com/questions/1657017/how-to-squash-all-git-commits-into-one
# squashes the WHOLE current tree into one
# CAREFUL
alias tcngitsquashallcommitsintoone='git reset $(git commit-tree HEAD^{tree} -m "A new start")'
