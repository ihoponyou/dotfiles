IMAGE=$HOME/dotfiles/wallpaper/thinker.png
BINARIES=$HOME/.local/bin

$BINARIES/swww kill; $BINARIES/swww-daemon & sleep 1 && $BINARIES/swww img $IMAGE
