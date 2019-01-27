# this is a python script to check sources for new videos and download them. This should run on a schedule.

# BEGIN PYTHON
#/usr/local/bin/youtube-dl -o /Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/%(title)s.%(ext)s -i -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 "https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33" 

# Documented way:

import youtube_dl

# set up logging
class MyLogger(object):
    def debug(self, msg):
        print(msg)

    def warning(self, msg):
        print(msg)

    def error(self, msg):
        print(msg)

# finished downloading message
def my_hook(d):
    if d['status'] == 'finished':
        print('Done downloading, now converting ...')

#Playlist Links

playlists = [
'https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33',
'https://www.youtube.com/playlist?list=PLA026E00FEC044A76',
'https://www.youtube.com/playlist?list=PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV',
]
#print (playlists)

#options
#more options - https://github.com/rg3/youtube-dl/blob/3e4cedf9e8cd3157df2457df7274d0c842421945/youtube_dl/YoutubeDL.py#L137-L312
ydl_opts = {
    'format': 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4',
#    'postprocessors': [{
#        'key': 'FFmpegExtractAudio',
#        'preferredcodec': 'mp3',
#        'preferredquality': '192',
#    }],
    'logger': MyLogger(),
    'progress_hooks': [my_hook],
}

with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download(playlists) # this works but downloads everything into the same directory


# this was originally running successfully as a bash script:

# Download Paths for reference - these should move to the setup.py 
#MUSIC VIDEOS
#MP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/'
#LP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofliveplaylist-PLA026E00FEC044A76/'
#SP='/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofaddtostreamplaylist-PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV/'

#Playlist Links
#ML='https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33'
#LL='https://www.youtube.com/playlist?list=PLA026E00FEC044A76'
#SL='https://www.youtube.com/playlist?list=PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV'

# youtube-dl options
# Y='%(title)s.%(ext)s -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4''

# this part would create a log file, add a date, then run the bash command
# the -o flag let's you set the output name
# ooftv music videos
#date >> $M
#echo youtube-dl results
#{ time /usr/local/bin/youtube-dl -o $MP$Y $ML ; } 2>> $M
# separate log entries
#echo $B >> $M

# ooftv live music archives
#date >> $L
#{ time /usr/local/bin/youtube-dl -o $LP$Y $LL ; } 2>> $L
#echo $B >> $L

# Playlist: Add To Stream
# ooftv stream playlist (this is an unlisted playlist set up for this script)
#date >> $S
#{ time /usr/local/bin/youtube-dl -o $SP$Y $SL ; } 2>> $S
#echo $B >> $S

#and here's a stripped down version of the actual downloader part without using variables:

#/usr/local/bin/youtube-dl -o /Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/%(title)s.%(ext)s -i -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33


