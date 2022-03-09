#!/usr/bin/env fish 

if test ! -e ./uninstall.fish
	echo "unsinstall.fish not in current directory please run the script from the dotfiles directory"
	exit
end

echo (test -d ./uninstall.fish)
unlink ../.config/nvim
unlink ../.config/i3
unlink ../.config/yambar
unlink ../.config/compton-cfg
