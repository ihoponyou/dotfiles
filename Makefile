.POSIX:

all: link

xdg_config_home_default:=$$HOME/.config
xdg_config_home:=$$XDG_CONFIG_HOME

ifeq ($(realpath xdg_config_home),$(an_unset_variable))
xdg_config_home:=$(xdg_config_home_default)
endif

# i only use alacritty and neovim on both windows and linux
# assuming shell properly accesses $APPDATA/$LOCALAPPDATA
# works with bash
ifeq ($(OS),Windows_NT)
alacritty_config_dir := $$APPDATA
neovim_config_dir := $$LOCALAPPDATA
else
alacritty_config_dir := $(xdg_config_home)
neovim_config_dir := $(xdg_config_home)
endif

make-dirs:
	mkdir -p $(alacritty_config_dir)
	mkdir -p $(neovim_config_dir)
	mkdir -p $(xdg_config_home_default)

link: make-dirs
	ln -sf $(realpath alacritty) $(alacritty_config_dir)
	ln -sf $(realpath nvim) $(neovim_config_dir)
ifneq ($(OS),Windows_NT)
	ln -sf $(realpath sway) $(xdg_config_home)
	ln -sf $(realpath tofi) $(xdg_config_home)
	ln -sf $(realpath waybar) $(xdg_config_home)
	ln -sf $(realpath .bashrc) $$HOME
	ln -sf $(realpath .tmux.conf) $$HOME
endif

clean:
	rm $(alacritty_config_dir)/alacritty
	rm $(neovim_config_dir)/nvim
ifneq ($(OS),Windows_NT)
	rm $(xdg_config_home)/sway
	rm $(xdg_config_home)/tofi
	rm $(xdg_config_home)/waybar
	rm $$HOME/.bashrc
	rm $$HOME/.tmux.conf
endif

.PHONY: all link make-dirs clean
