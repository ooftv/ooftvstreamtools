#!/bin/bash

# this is a simple script that downloads entire specified playlists
# this should be run with cron or on a schedule
# this should only download items not previously downloaded, so be careful to leave already downloaded
# videos in place or they will be re-downloaded the next time the script is run

# this will download any new playlist additions into a source video folder, then log what it did every time it runs. 
# It also keeps track of how long it took.

# to run this script with cron, we have to remind it where it can find youtube-dl and ffmpeg
# this is important because even though the command runs from a shell, and the script runs fine when manually started,
# it still partially fails in cron because youtube-dl can't find ffmpeg. The other part to this is setting the PATH in cron.
# I haven't tested whether it is necessary to have this both here and in cron
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0


# log files
# consider combining these into one log file
L='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/LiveMusicplaylistLog.txt'
S='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/AddToStreamplaylistLog.txt'
M='/users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/MusicVideoplaylistLog.txt'

# Download Paths
#MUSIC VIDEOS
MP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/'
LP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofliveplaylist-PLA026E00FEC044A76/'
SP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofaddtostreamplaylist-PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV/'

#Playlist Links
ML='https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33'
LL='https://www.youtube.com/playlist?list=PLA026E00FEC044A76'
SL='https://www.youtube.com/playlist?list=PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV'

#YouTube-dl Options
# working example:
# youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' https://www.youtube.com/watch?v=Z-s1MSbpKcc
# consider creating an index for videos to skip: https://askubuntu.com/questions/673442/downloading-youtube-playlist-with-youtube-dl-skipping-existing-files
# use -i to ignore errors (otherwise it stops on errors)
Y='%(title)s.%(ext)s -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4''

Log separator
B='================================================================'

# ++++++++++++++++++++++++
# Ok let's start the script commands
# ++++++++++++++++++++++++

# check the playlists and download new stuff

# ooftv music videos
date >> $M
echo youtube-dl results
{ time /usr/local/bin/youtube-dl -o $MP$Y $ML ; } 2>> $M
# separate log entries
echo $B >> $M

# ooftv live music archives
date >> $L
{ time /usr/local/bin/youtube-dl -o $LP$Y $LL ; } 2>> $L
echo $B >> $L

# Playlist: Add To Stream
# ooftv stream playlist (this is an unlisted playlist set up for this script)
date >> $S
{ time /usr/local/bin/youtube-dl -o $SP$Y $SL ; } 2>> $S
echo $B >> $S

