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
	HOSTNAME = builtins.readFile /etc/nixos/machine/hostname.txt;
	LOCAL_CONFIG = "/etc/nixos/machine/${HOSTNAME}.nix";

	# System vars
	#ETC = "/etc/";
	#LIB = "/var/lib";
	#SRV = "/srv";
	#CACHE = "/var/cache";
	#LOG = "/var/log";
in
{
	imports = [
			/etc/nixos/hardware-configuration.nix
			/etc/nixos/home/blox/default.nix
			"${LOCAL_CONFIG}"
		];

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		kernel.sysctl = {
			"vm.swappiness" = 5;
			"vm.min_free_kbytes" = 124792;
		};
	};

	environment = {
		variables = {
			# System vars
			#ETC = "$ETC";
			#LIB = "$LIB";
			#SRV = "$SRV";
			#CACHE = "$CACHE";
			#LOG = "$LOG";
		};
		pathsToLink = [ "/share/zsh" ];
	};

	security = {
		sudo.wheelNeedsPassword = false;
	};

	networking = {
		hostName = HOSTNAME;

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
			channel = https://nixos.org/channels/nixos-unstable;
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
		nix-serve = {
			enable = true;
			secretKeyFile = "/var/cache-priv-key.pem";
		};
		openssh = {
			enable = true;
			ports = [ 22 8080 ];
			permitRootLogin = "no";
			challengeResponseAuthentication = false;
			passwordAuthentication = false;
			kexAlgorithms = [ "curve25519-sha256@libssh.org" ];
		};
		cron = {
			enable = true;
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

	blox.users = {
		users = {
			root = {
				#home = "/home/root";
				#description = "";
				shell = pkgs.zsh;
				openssh.authorizedKeys.keyFiles = [ /home/josephtheengineer/var/lib/ssh/gpg_key.pub ];
				home-config = {
					xdg.enable = true;
					xdg.cacheHome = "/home/root/var/cache";
					xdg.configHome = "/home/root/etc";
					xdg.dataHome = "/home/root/var/lib";
				};
			};
			josephtheengineer = {
				isNormalUser = true;
				home = "/home/josephtheengineer";
				#description = "admin";
				extraGroups = [ "wheel" "libvirtd" "sway" "networkmanager"
					"video" "audio" "sound" "scanner" "lp" "website-dev" "cdrom" ];
				shell = pkgs.zsh;
				hashedPassword = "$6$1Zm3DuoP$ucsjGYsRrb.Bpm6eSLXAf9OQ.nKkbLfMR/rMJL.xzKnsFPSSFYByz1JtRbKeizfstszZUMiUUK2VRAssVBN9D1";
				openssh.authorizedKeys.keyFiles = [ /home/josephtheengineer/var/lib/ssh/gpg_key.pub ];
				home-config = {
					programs.git = {
						enable = true;
						userName = "josephtheengineer";
						userEmail = "joseph@theengineer.life";
					};
					xdg.enable = true;
					xdg.cacheHome = "/home/josephtheengineer/var/cache";
					xdg.configHome = "/home/josephtheengineer/etc";
					xdg.dataHome = "/home/josephtheengineer/var/lib";
				};
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
		cryptsetup
		lvm2
		parted
		kitty
		lolcat
		toilet
		nmap
		btrfs-progs
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
	system.stateVersion = "20.09";
}
