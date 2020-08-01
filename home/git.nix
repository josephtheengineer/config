{ config, pkgs, ... }:
{
	programs.git = {
		enable = true;
		package = pkgs.gitAndTools.gitFull;
		#	delta = {
		#		enable = true;
		#		options = [
		#			"--plus-color '#008000'"
		#			"--minus-color '#800000'"
		#			#"--dark"
		#		];
		#	};
		lfs.enable = true;
		signing = {
			key = "AD8F533C2A7BFE826A30C4D74A5C569F26265D31";
			signByDefault = true;
			#gpgPath = "/etc/zsh/server-command.sh gpg";
		};

		extraConfig = {
			commit = {
				template = "/etc/nixos/home/template.txt";
			};
			help = {
				autocorrect = 30;
			};
			pull = {
				rebase = true;
			};
			sendemail = {
				smtpuser = "joseph@theengineer.life";
				smptserver = "mail.theengineer.life";
				chainreplyto = false;
				composeencoding = "UTF-8";
			};
			#interactive = {
			#	diffFilter = "delta --color-only";
			#};
		};
	};
}
