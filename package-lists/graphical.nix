{ config, pkgs, ... }:

{
	environment.systemPackages = with pkgs; [
		#### Graphical ####
		# Info
			conky

		# Tools
			wofi
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
			zeroad
			lutris-free

		# Networking / Internet
			qutebrowser
			networkmanagerapplet
			qtox

		# Multimedia
			gimp
			audacity
			kdenlive
			olive-editor
			pavucontrol
			wf-recorder
			mpv
			wallutils
			gource

		# Libraries

		# Hardware
			mesa
			mesa-demos
			vaapiVdpau
			libvdpau
			vdpauinfo

		# Development
			godot
			#freecad
			# fritzing # Circuit board design

		# Encryption

	];
}
