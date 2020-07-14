{ config, pkgs, ... }:
{
	programs.zsh = {
		enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		enableVteIntegration = true;
		autocd = true;
		dotDir = "etc/zsh";
		history = {
			extended = true;
			path = "var/lib/zsh/history";
			save = 100000;
			share = false;
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "agnoster";
		};
		initExtra = ''
			if [ "$(tty)" = "/dev/tty1" ]; then
				sway
				exit 0
			fi

			export MPD_HOST=/run/mpd/socket
			export EDITOR="nvim"

			compinit -d "$CACHE/zsh/zcompdump"

			HYPHEN_INSENSITIVE="true"
			ENABLE_CORRECTION="true"
			COMPLETION_WAITING_DOTS="true"

			source /etc/zsh/session-variables.sh
			source /etc/zsh/load-aliases.sh


			system-info --startup
		'';
		#loginExtra = "";
		#logoutExtra = "";
		shellAliases = {
		# sortcuts
			network = "nmtui";
			update = "sudo nixos-rebuild switch --upgrade --repair --keep-going";
			config = "sudo nvim /etc/nixos/configuration.nix";
			refresh = "clear; neofetch; date; ls";
			cd = "cd-ls";
			rm = "rm -i";
			reboot = ''echo "Rebooting $(hostname) in 5 seconds. Press Ctrl+C to cancel"; sleep 7 && reboot'';
			poweroff = ''echo "Shutting down $(hostname) in 5 seconds. Press Ctrl+C to cancel"; sleep 7 && poweroff'';
			task-manager = "htop";
			system-monitor = "gotop";
			file-manager = "ranger";
			rebuild = "sudo nixos-rebuild switch --keep-going";
			web-browser = "qutebrowser";
			e = "nvim";
			c = "configure";
			alsamixer = "alsamixer -g";
			reload-agent = "gpg-connect-agent reloadagent /bye";
			icat = "kitty +kitten icat";
			lsblk = "lsblk -o name,size,mountpoint,uuid";
			rcp = "rsync --partial --progress --append --rsh=ssh -r -h";
			rmv = "rsyncmv";
			#cp = "cp-progress";
			#mv = "mv-progress";
			ls-size = "ls --human-readable --size -1 -S --classify";
			clear-swap = "sudo swapoff -a && sudo swapon -a";
			find-gateway = "route -n | grep 'UG[ \t]' | awk '{print $2}'";
			search-folder = "grep -rnw . -e ";
			youtube-dl = "yt-dl-best";
			create-mixer = "pactl load-module module-null-sink sink_name=inputs; pactl load-module module-loopback sink=inputs; pactl load-module module-loopback sink=inputs";
			#pass = "ssh -tq ssh.theengineer.life pass";
			old-term = "export TERM=vt100";
			create-playlist = "find -regex '.*\.\(webm\)' > index";


		# Linux commands
			#cat = "$PLAN9/bin/cat";

		# folders
			school = "~/workspace/josephtheengineer.ddns.net/school";
		};
	};
}
