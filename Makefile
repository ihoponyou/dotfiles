.POSIX:

all: link

xdg_config_home_default:=$$HOME/.config
xdg_config_home:=$$XDG_CONFIG_HOME

ifeq ($(realpath xdg_config_home),$(an_unset_variable))
xdg_config_home:=$(xdg_config_home_default)
endif

# assuming shell properly accesses $APPDATA/$LOCALAPPDATA
# works with bash
ifeq ($(OS),Windows_NT)
alacritty_config_dir := $$APPDATA
neovim_config_dir := $$LOCALAPPDATA
godot_config_dir := $$APPDATA
else
alacritty_config_dir := $(xdg_config_home)
neovim_config_dir := $(xdg_config_home)
godot_config_dir := $(xdg_config_home_default)
endif

make-dirs:
	mkdir -p $(xdg_config_home_default)
	mkdir -p $(alacritty_config_dir)
	mkdir -p $(neovim_config_dir)

link: make-dirs
	ln -sf $(realpath alacritty) $(alacritty_config_dir)
	ln -sf $(realpath nvim) $(neovim_config_dir)
	ln -sf $(realpath godot) $(godot_config_dir)
ifneq ($(OS),Windows_NT)
	ln -sf $(realpath sway) $(xdg_config_home)
	ln -sf $(realpath tofi) $(xdg_config_home)
	ln -sf $(realpath waybar) $(xdg_config_home)
	ln -sf $(realpath dunst) $(xdg_config_home)
	ln -sf $(realpath gammastep) $(xdg_config_home)
	ln -sf $(realpath zsh)/.zshrc $$HOME
	ln -sf $(realpath zsh)/themes $$HOME/.oh-my-zsh/custom
	ln -sf $(realpath .tmux.conf) $$HOME
endif

clean:
	rm $(alacritty_config_dir)/alacritty
	rm $(neovim_config_dir)/nvim
	rm $(godot_config_dir)/godot
ifneq ($(OS),Windows_NT)
	rm $(xdg_config_home)/sway
	rm $(xdg_config_home)/tofi
	rm $(xdg_config_home)/waybar
	rm $(xdg_config_home)/dunst
	rm $(xdg_config_home)/gammastep
	rm $$HOME/.zshrc
	rm $$HOME/.oh-my-zsh/custom/themes
	rm $$HOME/.tmux.conf
endif

.PHONY: all link make-dirs clean
