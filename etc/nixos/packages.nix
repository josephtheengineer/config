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

		# Formatting / Storage
			groff
			tectonic
			pandoc
			R-packages
			ntfs3g

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

		# Multimedia
			ffmpeg
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

		# Encryption
			pass
	];
}
