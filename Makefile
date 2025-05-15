all: link

ifeq ($(OS),Windows_NT)
alacritty_config_dir := $${APPDATA}/alacritty
neovim_config_dir := $${LOCALAPPDATA}
else
alacritty_config_dir := $${XDG_CONFIG_HOME}
neovim_config_dir := $${XDG_CONFIG_HOME}
endif

make-dirs:
	mkdir -p $(alacritty_config_dir)
	mkdir -p $(neovim_config_dir)

link: make-dirs
	ln -sf $(realpath .)/alacritty.toml $(alacritty_config_dir)
	ln -sf $(realpath nvim) $(neovim_config_dir)

.PHONY: all link
