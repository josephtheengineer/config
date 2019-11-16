{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		#### Graphical ####
		qutebrowser
		gimp
		pavucontrol
		rofi
		godot
		conky
		kitty
		zathura
		grim
		wf-recorder
		mpv
		bemenu
		warzone2100
		the-powder-toy
		mako
		slurp
		waybar
		#virtboard
		wallutils
		gource
		networkmanagerapplet
		quakespasm
		poppler_utils
		multimc
		wl-clipboard
	];
}
