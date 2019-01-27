#!/bin/bash

killall "obs" # force quit OBS
nohup /Applications/OBS.app/Contents/MacOS/OBS --startstreaming >/dev/null 2>&1 # restart OBS and run it silently with nohup
