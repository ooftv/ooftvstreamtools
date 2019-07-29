#!/bin/bash

# this is a simple script that compresses folders that are auto-downloaded to,
# then moves the compressed versions into a compress folder.
# It should only compress new items
# it does this by comparing the download folder to the compress folder and compresses any missing items
# this gets called by the main script

# this is important because even though the command runs from a shell, and the script runs fine when manually started,
# it still partially fails in cron because youtube-dl can't find ffmpeg. The other part to this is setting the PATH in cron.
# I haven't tested whether it is necessary to have this both here and in cron
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0


# log files
# consider combining these into one log file
L='/Users/lorenrisker/Movies/ooftv/broadcast/logs/LiveMusicplaylistLog.txt'
S='/Users/lorenrisker/Movies/ooftv/broadcast/logs/AddToStreamplaylistLog.txt'
M='/users/lorenrisker/Movies/ooftv/broadcast/logs/MusicVideoplaylistLog.txt'

# Download Paths
#MUSIC VIDEOS
MP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/MusicVideos'
LP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/LiveVideos'
SP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/AddToStream'
OP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/ooforiginals'

#call this function with the path you want to use it on. For example:
# if your path is a youtube downloader folder assigned to a variable called $p :
# compress $p

compress() {
   cd $1 #not sure if right variable, but this changes to the folder grabbed from when I called the function.
   #pwd #debugging
   mkdir -p $1/compressed
   #ls #debugging
   for f in *.mp4; #finds all files in the folder that have a fileextension starting with m (mp4, m4v, mov)
   do
       echo working on $f # for debugging
       name=$(basename "$f") #strip the path
       echo basename= "$name" # for debugging
       extension="${name##*.}." #find the extension
       name="${name%.*}" #show only the filename without the extension
       echo checking: "$name"
if [[ ! -e "$1/compressed/"$name"-broadcast.mp4" ]]; then
       echo "$name" needs to be compressed
       echo compressing "$name" ...
       /usr/local/bin/ffmpeg -y -i "$f" -vf scale=1280:720 -c:v libx264 -b:v 1500k -pass 1 -c:a aac -b:a 128k -f mp4 /dev/null && /usr/local/bin/ffmpeg -i "$f" -vf scale=1280:720 -c:v libx264 -b:v 1500k -pass 2 -c:a aac -b:a 128k -f mp4 "compressed/${f%.*}-broadcast.mp4"
   fi
   done
}

#Log separator
B='================================================================'

# ++++++++++++++++++++++++
# Ok let's start the script commands
# ++++++++++++++++++++++++

compress $MP
compress $LP
compress $SP
compress $OP
