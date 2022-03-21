#!/bin/bash

# this script rsyncs from the computer that downloads and compresses new videos to the ooftvstream server

#define folders to rsync
source=../sourcevideos/
destination=/media/oofvideos/broadcast/autodownload/
echo "source = " $source
echo "destination = " $destination
/usr/bin/rsync -v --delete -r -t -e ssh $source osmc@ooftvstream.local:"$destination"
