{ config, pkgs, ... }:
with pkgs;
let
        R-packages = rWrapper.override{ packages = with rPackages; [ rmarkdown ]; };
in
{
	environment.systemPackages = with pkgs; [
		#### Terminal ####
		# Info
			neofetch
			acpi
			file
			glxinfo

		# Tools
			unzip
			zip
			bcache-tools
			youtube-dl
			patchelf
			fzf # Full screen fuzzy finder
			calcurse # Full screen calender and to-do list
			termdown
			taskwarrior
			timewarrior
			tasksh
			vit

		# Formatting / Storage
			groff
			tectonic
			pandoc
			tetex
			R-packages
			ntfs3g
			usbutils # Mount android phones
			sshfs # Mount dir via ssh

		# Fun
			figlet
			fortune
			cowsay
			bsdgames # Full screen
			cmatrix # Full screen

		# Networking / Internet
			iw # Wireless config
			iwd # Internet wireless daemon
			ppp # Point to point protocal
			ncat # Concatenate and redirect sockets
			stunnel # TLS offloading and load-balancing proxy
			telnet
			linuxPackages.usbip
			weechat # Full screen
			rtorrent # Full screen
			w3m # Full screen web browser
			links # Full screen web browser
			aerc # Full screen mail client
			linux-pam
			tor
			ddgr # Duck Duck Go over the terminal

		# Multimedia
			ffmpeg-full
			mpd
			ncmpcpp # Full screen frontend UI for mpd
			mpc_cli # Full screen

		# Libraries
			adoptopenjdk-bin

		# Hardware
			system-config-printer
			sane-backends # Scanner
			paperless # Scanning mangement + OCR

		# Development
			gnumake
			clang
			gdb
			androidenv.androidPkgs_9_0.platform-tools # For mounting android phones + running apps
	];
}
