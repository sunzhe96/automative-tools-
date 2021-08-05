#!/bin/sh

fileName=$(date +%Y-%m-%d-%H:%M:%S)
device=$(pacmd list-sources  | grep name: | grep in | awk -F " " '{ print $2 }' | tr -d '<>')
dir="$HOME/Audio"

parecord -d "$device" -r "$dir/$fileName.wav"
