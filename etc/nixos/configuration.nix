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
#with pkgs;
let
	HOSTNAME = builtins.readFile ./hostname.txt;
	LOCAL_CONFIG = "/home/josephtheengineer/local/etc/nixos/${HOSTNAME}.nix";
#	home-manager = builtins.fetchGit {
#		url = "https://github.com/rycee/home-manager.git";
#		rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed"; # CHANGEME
#		ref = "release-18.09";
#	};
in
{
	imports = [
			/etc/nixos/hardware-configuration.nix
			"${LOCAL_CONFIG}"
#			"${home-manager}/nixos"
		];

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
	};

	environment = {
		extraInit = "
		# Local vars
		export CACHE=~/local/var/cache
		export ETC=~/local/etc
		export LIB=~/local/lib
		export LOG=~/local/var/log
		export SRV=/srv
		export DESKTOP=~/desktop
		export DOWNLOADS=~/downloads

		# XDG compatibility
		export XDG_CACHE_HOME=$CACHE
		export XDG_CONFIG_HOME=$ETC
		export XDG_DATA_HOME=$LIB
		export XDG_STATE_HOME=$LOG
		export XDG_LIB_HOME=$LIB
		export XDG_LOG_HOME=$LOG

		# XDG user dirs compatibility
		XDG_DESKTOP_DIR=$DESKTOP
		XDG_DOCUMENTS_DIR=$DESKTOP
		XDG_DOWNLOAD_DIR=$DOWNLOADS
		XDG_MUSIC_DIR=$DESKTOP
		XDG_PICTURES_DIR=$DESKTOP
		XDG_PUBLICSHARE_DIR=$SRV
		XDG_TEMPLATES_DIR=$LIB/templates
		XDG_VIDEOS_DIR=$DESKTOP

		# Application compatibility
		export GIMP2_DIRECTORY=$LIB/gimp
		export GNUPGHOME=$LIB/gnupg
		export GTK2_RC_FILES=$ETC/gtk-2.0/
		export LESSHISTFILE=$LIB/lesshist
		export NETHACKOPTIONS=$ETC/nethack/nethackrc
		export PASSWORD_STORE_DIR=$LIB/pass
		export PGPPATH=$GNUPGHOME
		export PYTHONSTARTUP=$LIB/python/startup.py
		export ZDOTDIR=$ETC/zsh
		export PULSE_SOURCE=$ETC/pulse/client.conf
		export PULSE_COOKIE=$CACHE/pulse/cookie
		";
	};

	security = {
		sudo.wheelNeedsPassword = false;
	};

	networking = {
		networkmanager.enable = true;

		hosts = {
			#"202.137.162.57" = [ "school" ];
		};

		#proxy = {
		#	default = "socks5://localhost:8080";
		#	noProxy = "josephtheengineer.ddns.net,127.0.0.1,localhost,internal.domain";
		#};
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
			ports = [ 22 8080 ];
			permitRootLogin = "no";
			#challengeResponseAuthentication = false;
			#passwordAuthentication = false;
		};
	};

	programs = {
		zsh = {
			enable = true;
			histFile = "\$HOME/local/lib/zsh/history";
			ohMyZsh.enable = true;
			ohMyZsh.theme = "agnoster";
			promptInit = ''
				export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
			'';
			syntaxHighlighting.enable = true;
		};
	};

	users = {
		groups.website-dev = {};
		users = {
			josephtheengineer = {
				isNormalUser = true;
				home = "/home/josephtheengineer";
				description = "admin";
				extraGroups = [ "wheel" "libvirtd" "sway" "networkmanager"
					"video" "scanner" "lp" "website-dev" "cdrom" ];
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
	};

	console = {
		keyMap = "colemak";
	};

	i18n = {
		defaultLocale = "en_US.UTF-8";
	};

	time.timeZone = "Australia/Brisbane";

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		neovim
		git
		gotop
		wget
		htop
		tmux
		lf
		tree
		plan9port
		progress
		gnupg
		pinentry
		cryptsetup
		lvm2
		parted
		networkmanager
		kitty
		lolcat
		toilet
		nmap
	];

	fonts = {
		enableFontDir = true;
		fonts = with pkgs; [
			powerline-fonts
			envypn-font
			roboto-mono
			roboto
			source-sans-pro
			source-code-pro
			noto-fonts
			noto-fonts-cjk
			noto-fonts-emoji
			noto-fonts-extra
			twitter-color-emoji
		];
		enableDefaultFonts = true;
		#fontconfig = {
		#	ultimate.enable = true;
		#	#defaultFonts.emoji = [ "Twitter Color Emoji" ];
		#};
	};

	# You should change this only after the release notes say you should.
	system.stateVersion = "18.09";
}
