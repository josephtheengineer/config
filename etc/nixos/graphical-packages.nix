{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		#### Graphical ####
		# Info
			conky

		# Tools
			rofi
			bemenu
			waybar
			zathura
			grim
			slurp
			mako
			#virtboard
			poppler_utils
			wl-clipboard

		# Formatting

		# Fun
			warzone2100
			the-powder-toy
			quakespasm
			multimc

		# Networking / Internet
			qutebrowser
			networkmanaperapplet

		# Multimedia
			gimp
			pavucontrol
			wf-recorder
			mpv
			wallutils
			gource

		# Libraries

		# Hardware

		# Development
			godot

		# Encryption

	];
}
