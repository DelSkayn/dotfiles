#!/usr/bin/env fish 

if test ! -e ./setup.fish
	echo "setup.fish not in current directory please run the script from the dotfiles directory"
	exit
end
ln -s (pwd)/config/nvim ../.config/nvim
ln -s (pwd)/config/i3 ../.config/i3
ln -s (pwd)/config/yambar ../.config/yambar
ln -s (pwd)/config/compton-cfg ../.config/compton-cfg
ln -s (pwd)/config/wezterm ../.config/wezterm
ln -s (pwd)/config/sway ../.config/sway
ln -s (pwd)/config/hypr ../.config/hypr
ln -s (pwd)/config/eww ../.config/eww
ln -s (pwd)/config/alacritty ../.config/alacritty
