#!/bin/bash

IMAGE=$HOME/dotfiles/wallpaper/cycles-1920-1080.png

awww query &> /dev/null
if [ $? -eq 0 ]
then
	exit 0;
fi

awww-daemon -q & sleep 1 && awww img $IMAGE
