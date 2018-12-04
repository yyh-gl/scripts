#!/bin/zsh

figlet -f slant "<<< One Up! >>>" &&
rsync -ah --delete ~/Desktop/95_修士論文 ~/Desktop/01_ISDL/03_Conference/ &
rsync -ah ~/Desktop/95_修士論文 ~/OneDrive\ -\ 同志社大学/同期フォルダ/ &
progress -m &&
figlet -f slant "<<< All Done >>>"
