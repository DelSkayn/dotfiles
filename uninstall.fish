if test -d setup.fish
	echo "setup.fish not in current directory please run the script from the dotfiles directory"
	exit
end
unlink ../.config/nvim