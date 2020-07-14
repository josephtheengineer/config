{ config, pkgs, ... }:
{
	imports = [
		/etc/nixos/boot/grub.nix
		/etc/nixos/package-lists/server.nix
		/etc/nixos/services/mail.nix
		/etc/nixos/services/git.nix
		/etc/nixos/services/irc.nix
		/etc/nixos/services/website.nix
		/etc/nixos/services/pihole.nix
	];

	networking = {
		firewall = {
			allowedTCPPorts = [ 13 22 8888 25565 8080 8088 25 4190 993 995 5000 5353 587 110 143 80 443 113 12340 53 67 546 5353 8787 465 6667 6664 23 3000 6379 ];
			allowedUDPPorts = [ 13 22 8888 25565 8080 8088 25 4190 993 995 5000 5353 587 110 143 80 443 113 12340 53 67 546 5353 8787 465 6667 6664 23 3000 6379 ];
		};
	};

	environment.systemPackages = with pkgs; [
		nodejs
		ddclient
	];


	blox.home-manager.config =
		{ pkgs, ... }:
		{
			imports = [
				/etc/nixos/home/home.nix
				/etc/nixos/home/server/server.nix
			];
		}
	;
}
