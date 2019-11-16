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
#let
#	home-manager = builtins.fetchGit {
#		url = "https://github.com/rycee/home-manager.git";
#		rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed"; # CHANGEME
#		ref = "release-18.09";
#	};
#in
{
	imports = [
			/etc/nixos/hardware-configuration.nix
			./local-configuration.nix
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

		# XDG compatibility
		export XDG_CACHE_HOME=$CACHE
		export XDG_CONFIG_HOME=$ETC
		export XDG_DATA_HOME=$LIB
		export XDG_STATE_HOME=$LOG
		export XDG_LIB_HOME=$LIB
		export XDG_LOG_HOME=$LOG

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
		";
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
			ports = [ 22 ];
			permitRootLogin = "no";
			challengeResponseAuthentication = false;
			passwordAuthentication = false;
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
	];

	fonts = {
		fonts = with pkgs; [
			symbola
			powerline-fonts
			envypn-font
			roboto-mono
			source-sans-pro
			source-code-pro
			noto-fonts-emoji
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
