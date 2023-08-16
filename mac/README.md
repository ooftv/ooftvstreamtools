isntall homebrew with:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

install vlc with 
brew install vlc

plmaker requires gshuf. install with
brew install coreutils

use a launchdaemon to run plmaker every night by creating a symbolic link to the launchdaemon in this folder
sudo chown root /usr/local/bin/ooftv/mac/tv.outoffocus.plmaker.plist
sudo ln -s /usr/local/bin/ooftv/mac/tv.outoffocus.plmaker.plist /Library/LaunchDaemons/
use a launchdaemon to restart the stream every night
sudo chown root /usr/local/bin/ooftv/mac/tv.outoffocus.streamer.plist
sudo ln -s /usr/local/bin/ooftv/mac/tv.outoffocus.streamer.plist /Library/LaunchDaemons/

check /tmp for logs and errors
