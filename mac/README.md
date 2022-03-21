plmaker requires gshuf. install with
brew install coreutils

use a launchdaemon to run plmaker every night by creating a symbolic link to the launchdaemon in this folder
sudo ln -s /usr/local/bin/ooftv/mac/tv.outoffocus.plmaker.plist /Library/LaunchDaemons/
use a launchdaemon to restart the stream every night
sudo ln -s /usr/local/bin/ooftv/mac/tv.outoffocus.streamer.plist /Library/LaunchDaemons/
