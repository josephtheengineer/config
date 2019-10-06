#           ██                         
#          ░░                          
#  ███████  ██ ██   ██  ██████   ██████
# ░░██░░░██░██░░██ ██  ██░░░░██ ██░░░░ 
#  ░██  ░██░██ ░░███  ░██   ░██░░█████ 
#  ░██  ░██░██  ██░██ ░██   ░██ ░░░░░██
#  ███  ░██░██ ██ ░░██░░██████  ██████ 
# ░░░   ░░ ░░ ░░   ░░  ░░░░░░  ░░░░░░  

# /etc/nixos/configuration.nix
# man configuration.nix // nixos-help

{ config, pkgs, ... }:
with pkgs;
let
	R-packages = rWrapper.override{ packages = with rPackages; [ rmarkdown ]; };
in
{
	imports = [
			/etc/nixos/hardware-configuration.nix
			./local-configuration.nix
		];

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		loader = {
			grub.enable = false;
			# Use the systemd-boot EFI boot loader.
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
	};

	networking = {
		networkmanager.enable = true;
		
		# Open ports in the firewall.
		firewall = {
			allowedTCPPorts = [ 13 22 8888 25565 8080 ];
			allowedUDPPorts = [ 13 22 8888 25565 8080 ];
		};

		#proxy = {
		#	default = "socks5://localhost:8080";
		#	noProxy = "josephtheengineer.ddns.net,127.0.0.1,localhost,internal.domain";
		#};
	};

	hardware = {
		pulseaudio.enable = true;
		bluetooth.enable = true;
	};

	system = {
		autoUpgrade = {
			enable = true;
			channel = "https://nixos.org/channels/nixos-unstable";
		};
	};

	nix = {
		gc = {
			automatic = true;
			dates = "12:00";
		};
		autoOptimiseStore = true;
	};

	services = {
		openssh = {
			enable = true;
			ports = [ 22 123];
			permitRootLogin = "no";
			#challengeResponseAuthentication = false;
			#passwordAuthentication = false;
		};
		printing = {
			enable = true;
			drivers = [ pkgs.gutenprint ];
		};
		#paperless = {
		#	enable = true;
		#	consumptionDir = "/var/spool/scans/";
		#	extraConfig = {
		#		PAPERLESS_CORS_ALLOWED_HOSTS="http://localhost:8080";
		#	};
		#};
	};

	programs = {
		dconf.enable = true;
		light.enable = true;
		sway.enable = true;
		zsh = {
			enable = true;
			histFile = "\$HOME/.local/share/zsh/history";
			ohMyZsh.enable = true;
			ohMyZsh.theme = "agnoster";
			promptInit = ''
				export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
				export ZDOTDIR="/home/josephtheengineer/.config/zsh"
			'';
			syntaxHighlighting.enable = true;
		};
	};

	users.users = {
		josephtheengineer = {
			isNormalUser = true;
			home = "/home/josephtheengineer";
			description = "admin";
			extraGroups = [ "wheel" "libvirtd" "sway" "networkmanager" "video" "scanner" "lp" ];
			shell = pkgs.zsh;
		};
		eco = {
			isNormalUser = true;
			home = "/home/eco";
			description = "awesome";
			extraGroups = [];
			shell = pkgs.zsh;
		};
	};

	i18n = {
		consoleKeyMap = "colemak";
		defaultLocale = "en_US.UTF-8";
	};

	security.pki.certificates =		[ ''
-----BEGIN CERTIFICATE-----
MIIEmDCCA4CgAwIBAgIJAIn2s0rMQBBXMA0GCSqGSIb3DQEBCwUAMIGOMS0wKwYD
VQQDFCRDeWJlckhvdW5kIFtwYWR1YXFsZF0gMjAxODA3MTIwNDAzMjExCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpRdWVlbnNsYW5kMREwDwYDVQQHEwhCcmlzYmFuZTET
MBEGA1UEChMKQ3liZXJIb3VuZDETMBEGA1UECxMKQ3liZXJIb3VuZDAeFw0xODA3
MTExODAzMjFaFw0yODA3MDgxODAzMjFaMIGOMS0wKwYDVQQDFCRDeWJlckhvdW5k
IFtwYWR1YXFsZF0gMjAxODA3MTIwNDAzMjExCzAJBgNVBAYTAkFVMRMwEQYDVQQI
EwpRdWVlbnNsYW5kMREwDwYDVQQHEwhCcmlzYmFuZTETMBEGA1UEChMKQ3liZXJI
b3VuZDETMBEGA1UECxMKQ3liZXJIb3VuZDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAMTZyACeFFfg3NKbFCR6WBW/Bq3kax4kUaBye0RFZ/n9oNtoaWYu
rh1Z2zQ9Qb/C+W9UhyYZERYq+8mWTf1Ct1h01juw2vQ2jb5qHOEptJPBLhHEq7u8
VOyRQKZwvDsqA7HnU+FLW6x5LCHBXcmX6dqSA+4x++besPDzDaWXqaESqiHzj5nI
yCwR2II4a1BK8tmoTfVURDFnXMuioWaNgI9FDsgRVPZuK9jj8kZ2JRuDIXO4brvn
2tGl4fj1vrSdVbPZCpM0zTbb0N7poRtchu4/8LYZqjG0GOZugiKvrlzWRJaH+Fsp
FPhSRdDuXfP0aX+6TROXzR3WOxN44MmFGxUCAwEAAaOB9jCB8zAdBgNVHQ4EFgQU
/8Ls9wibnC5SUKDhcN0dwIC9SK0wgcMGA1UdIwSBuzCBuIAU/8Ls9wibnC5SUKDh
cN0dwIC9SK2hgZSkgZEwgY4xLTArBgNVBAMUJEN5YmVySG91bmQgW3BhZHVhcWxk
XSAyMDE4MDcxMjA0MDMyMTELMAkGA1UEBhMCQVUxEzARBgNVBAgTClF1ZWVuc2xh
bmQxETAPBgNVBAcTCEJyaXNiYW5lMRMwEQYDVQQKEwpDeWJlckhvdW5kMRMwEQYD
VQQLEwpDeWJlckhvdW5kggkAifazSsxAEFcwDAYDVR0TBAUwAwEB/zANBgkqhkiG
9w0BAQsFAAOCAQEANpjrjFnCTomRurzQl+ETzVHofv4+xstmpBDVHddlZg4b7Krs
LzACkT++e6fkssbs+vLaAeQyzJzQH1wHYKqxd320GuPye6WNz0FLRO0yV0JY+bOJ
68va06LHYhPw05cDqOmLfKnfZZ9kOgmTCJvuPJJYronifC2fmy6KpEYJvzbjNEPS
1VmG3INtV5TkRwl+oWFYGg4NpXac7E6kQiznqWV/tcPrgICI4jYO8PTf1fF9ac/d
FpD1xWRghELBKaJAbGKNmZa5+bcypaYRoj7G8m2Ko0xjx4/xfC2H8yrZEL8ID8Ke
cvYrtmo4ql4TaI9ssx31VlCAgaK0XEdlDZ6R+A==
-----END CERTIFICATE-----

				'' 
				];

	time.timeZone = "Australia/Brisbane";
	virtualisation.libvirtd.enable = true;
	sound.enable = true;
	  
	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		wget
		neovim
		htop
		qutebrowser
		neofetch
		gotop
		gimp
		nodejs
		arc-theme
		gtk-engine-murrine
		arc-icon-theme
		breeze-gtk
		capitaine-cursors
		zsh
		git
		pavucontrol
		ranger
		firefox
		unzip
		nix-prefetch-git
		zip
		stdenv
		bcache-tools
		weechat
		toilet
		lolcat
		rtorrent
		networkmanager
		cryptsetup
		lvm2
		xorg.xrdb
		iw
		iwd
		capitaine-cursors
		parted
		ffmpeg
		adoptopenjdk-bin
		arc-icon-theme
		ppp
		pptp
		rofi
		godot
		system-config-printer
		w3m
		gnumake
		youtube-dl
		tigervnc
		conky
		kitty
		fortune
		cowsay
		bsdgames
		gnupg
		mpd
		ncmpcpp
		mpc_cli 
		file
		acpi
		groff
		tectonic
		zathura
		cmatrix
		pandoc
		R-packages
		grim
		ncat
		nmap-graphical
		stunnel
		glxinfo
		wf-recorder
		mpv
		bemenu
		warzone2100
		the-powder-toy
		wl-clipboard
		mako
		slurp
		waybar
		#virtboard
		wallutils
		gource
		networkmanagerapplet
		aerc
		telnet
		pass
		bind
		quakespasm
		patchelf
		saneBackends
		#paperless
		figlet
		clang
		paperless
		gdb
		poppler_utils
		openssl
	];

	fonts = {
		fonts = with pkgs; [
			symbola
			powerline-fonts
			envypn-font
			roboto-mono
			source-sans-pro
			source-code-pro
		];
		enableDefaultFonts = true;
		fontconfig.ultimate.enable = true;
	};

	# You should change this only after the release notes say you should.
	system.stateVersion = "18.09";
}
