#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export DISPLAY=:0.0

# this scripts
# 1) Finds Videos
# 2) Puts them into a playlist
# 3) Shuffles them up
# 4) (still in progress) Makes sure certian videos play every so many videos # for example it will play something from the promo folder every 10 videos

d=$(date +%Y-%m-%d) # use this to give playlists a unique name
log=/tmp/PLMaker.log
echo "================PLMaker ran" $d "======================">> /tmp/PLMaker.log
#set base url, otherwise script will fail. after changing the baseurl disable to log 

echo "Did you remember to set a basePath at the top of the script?" >> /tmp/PLMaker.log
basePath='/home/osmc/ooftv'
echo "baseURL = " $baseURL

# Paths to compressed videos:
# Music Videos
musicvideos=$basePath'/broadcast/musicvideos'
# Live Videos
livevideos=$basePath'/broadcast/live'
# Other videos
othervideos=$basePath'/broadcast/othervideos'
# OOF Promos
promos=$basePath'/broadcast/promos'
# OOF Series
series=$basePath'/broadcast/series'

# Playlist Path
listPath=$basePath'/broadcast/playlists'

echo "Let's check our paths, Do they look ok?" >> $log
echo $musicvideos >> $log
echo $livevideos >> $log
echo $othervideos >> $log
echo $promos >> $log
echo $series >> $log
echo $listPath >> $log
echo "============================"
# Playlist Creator

echo $d
listName=$d-playlist.m3u # name the ordered playlist
shufList=$d-playlist-shuf.m3u # name the shuffled playlist
echo "Let's call the playlist" $listName
echo "Let's call the shuffled playlist" $shufList
echo "Creating playlists..."
# Compile everything into a playlist
# the -d prints the entire path instead of just the contents which is needed for this to work as a playlist
# ls -d "$MPC"/*.mp4 >> $listPath/$listName # don't include music video playlist as its not vetted for rights


# perhaps a better method would be:
# ls -dl $PWD/*
# which adds the path to the filename in one step
echo "writing folder contents to " $listPath/$listName >> $log
ls -d "$musicvideos"/*.mp4 >> $listPath/$listName
ls -d "$livevideos"/*.mp4 >> $listPath/$listName
ls -d "$othervideos"/*.mp4 >> $listPath/$listName
ls -d "$promos"/*.mp4 >> $listPath/$listName
ls -d "$series"/*.mp4 >> $listPath/$listName

# Shuffle the playlist
# this relies on gshuf which is not installed natively on a mac. can be installed with brew install coreutils
# osmc may use shuf instead of gshuf
# this uses tee to send the output to two files, one named for the date (for records) and one simply overwrites the playlist called today.m3u
# obs (or whatever streamer you want) will just always point to the file called today.m3u which will be refreshed everytime the script is run
/usr/bin/shuf $listPath/$listName | tee $listPath/$shufList $listPath/today.m3u > /dev/null
