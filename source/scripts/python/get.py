#this is a python script to check sources for new videos and download them. This should run on a schedule.

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

playlist = [
'https://www.youtube.com/playlist?list=PLF06E26B33B6A2F33',
'https://www.youtube.com/playlist?list=PLA026E00FEC044A76',
'https://www.youtube.com/playlist?list=PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV',
]
#print (playlist)

#download locations
testpath = [
    '/users/lorenrisker/Movies/ooftv/broadcast/scripts/python/test1/%(title)s-%(id)s.%(ext)s'
    '/users/lorenrisker/Movies/ooftv/broadcast/scripts/python/test2/%(title)s-%(id)s.%(ext)s'
]

path = [
'/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/musicvideoplaylist-PLF06E26B33B6A2F33/',
'/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofliveplaylist-PLA026E00FEC044A76/',
'/Users/lorenrisker/Movies/ooftv/broadcast/sourcevideos/oofaddtostreamplaylist-PLmvDDOT4vxZd4th9yXtHKXc6HSA_93nlV/',
]
#print (path)
#options
#more options - https://github.com/rg3/youtube-dl/blob/3e4cedf9e8cd3157df2457df7274d0c842421945/youtube_dl/YoutubeDL.py#L137-L312
ydl_opts = {
    'format': 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4',
    'logger': MyLogger(),
    'progress_hooks': [my_hook],
    'outmpl': '/users/lorenrisker/Movies/ooftv/broadcast/scripts/python/test2/%(title)s-%(id)s.%(ext)s',
}

ydl_path = {
    'outputmpl': testpath[0]
} 
# I think I need to change next line to "with youtube_dl.YoutubeDL(ydl_opts, ydl_path) as ydl:
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download(playlist)
print (playlist[2])

