.POSIX:

all: link

xdg_config_home_default:=$$HOME/.config
xdg_config_home:=$$XDG_CONFIG_HOME

# this may or may not be working as intended
ifeq ($(realpath xdg_config_home),$(an_unset_variable))
xdg_config_home:=$(xdg_config_home_default)
endif

ifeq ($(OS),Windows_NT)
alacritty_config_dir := $$APPDATA/alacritty
neovim_config_dir := $$LOCALAPPDATA
else
alacritty_config_dir := $(xdg_config_home)
neovim_config_dir := $(xdg_config_home)
endif

make-dirs:
	@echo $$HOME
	@echo $(xdg_config_home_default)
	@echo $(xdg_config_home)
	mkdir -p $(alacritty_config_dir)
	mkdir -p $(neovim_config_dir)

link: make-dirs
	ln -sf $(realpath .)/alacritty.toml $(alacritty_config_dir)
	ln -sf $(realpath nvim) $(neovim_config_dir)

clean:
	rm -rf ~/.config/nvim/
	rm -f ~/.config/alacritty.toml

.PHONY: all link make-dirs clean
