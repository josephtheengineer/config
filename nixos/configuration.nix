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
	LOCAL_CONFIG = "/home/josephtheengineer/etc/nixos/${HOSTNAME}.nix";

	# System vars
	#ETC = "/etc/";
	#LIB = "/var/lib";
	#SRV = "/srv";
	#CACHE = "/var/cache";
	#LOG = "/var/log";

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
		noXlibs = true;
		variables = {
			FONTCONFIG_FILE = "/nix/store/k5v4lkcmsdrl6qr4w36dfljbrzp1j532-etc/etc/fonts/fonts.conf";
			# System vars
			#ETC = "$ETC";
			#LIB = "$LIB";
			#SRV = "$SRV";
			#CACHE = "$CACHE";
			#LOG = "$LOG";
		};
	};

	security = {
		sudo.wheelNeedsPassword = false;
	};

	networking = {
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
			challengeResponseAuthentication = false;
			passwordAuthentication = false;
		};
	};

	programs = {
		zsh = {
			enable = true;
			histFile = "\$HOME/var/lib/zsh/history";
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
		#enableFontDir = true;
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
		#enableDefaultFonts = true;
		#fontconfig = {
		#	ultimate.enable = true;
		#	#defaultFonts.emoji = [ "Twitter Color Emoji" ];
		#};
	};

	# You should change this only after the release notes say you should.
	system.stateVersion = "18.09";
}
