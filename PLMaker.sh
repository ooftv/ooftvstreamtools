# this scripts 
# 1) Finds Videos
# 2) Puts them into a playlist
# 3) Shuffles them up
# 4) Makes sure certian videos play every so many videos
# for example it will play something from the promo folder every 10 videos

# Paths to compressed videos:
# Music Videos
MPC='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/compressed'
# Live Videos
LPC='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofliveplaylist-PLA026E00FEC044A76/compressed'
# Add To Stream Playlist
SPC='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofaddtostreamplaylist-PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV/compressed'
# OOF Originals
OPC='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/ooforiginals'
# Promos
# Shorts and extras
# Old broadcast folder (should clean up, sort, and remove)
OLD='/Users/lorenrisker/Movies/OOFTV/Broadcast/Approved for Broadcast/Compressed'
# Playlist Path
listPath='/Users/lorenrisker/Movies/ooftv/broadcast/playlists'

# Playlist Creator
d=$(date +%Y-%m-%d) # use this to give playlists a unique name
echo $d
listName=$d-playlist.m3u # name the ordered playlist
shufList=$d-playlist-shuf.m3u # name the shuffled playlist
echo $listName
echo $shufList
# Compile everything into a playlist
# the -d prints the entire path instead of just the contents which is needed for this to work as a playlist
# ls -d "$MPC"/*.mp4 >> $listPath/$listName # don't include music video playlist as its not vetted for rights
ls -d "$LPC"/*.mp4 >> $listPath/$listName
ls -d "$SPC"/*.mp4 >> $listPath/$listName
ls -d "$OPC"/*.mp4 >> $listPath/$listname
ls -d "$OLD"/*.mp4 >> $listPath/$listname

# Shuffle the playlist
# this relies on gshuf which is not installed natively. can be installed with brew install coreutils
# this uses tee to send the output to two files, one named for the date (for records) and one simply overwrites the playlist called today.m3u
# obs (or whatever streamer you want) will just always point to the file called today.m3u which will be refreshed everytime the script is run
/usr/local/bin/gshuf $listPath/$listName | tee $listPath/$shufList $listPath/today.m3u > /dev/null

