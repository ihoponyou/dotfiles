#!/bin/bash

IMAGE=$HOME/dotfiles/wallpaper/thinker.png

swww query &> /dev/null
if [ $? -eq 0 ]
then
	exit 0;
fi

swww-daemon -q & sleep 1 && swww img $IMAGE
