{ config, pkgs, ... }:
{
	imports = [
		/etc/nixos/boot/systemd.nix
		/etc/nixos/boot/encrypted.nix
		/etc/nixos/package-lists/base.nix
		/etc/nixos/package-lists/graphical.nix
		/etc/nixos/enable-hardware.nix
		/etc/nixos/printing.nix
	];
	networking.firewall = {
		allowedTCPPorts = [ 13 22 8888 25565 8080 8088 25 4190 993 995 5000 5353 587 110 143 80 443 113 12340 53 67 546 5353 8787 465 6667 6664 23 3000 6379 ];
		allowedUDPPorts = [ 13 22 8888 25565 8080 8088 25 4190 993 995 5000 5353 587 110 143 80 443 113 12340 53 67 546 5353 8787 465 6667 6664 23 3000 6379 ];
	};


	blox.home-manager.config =
		{ pkgs, ... }:
		{
			imports = [
				/etc/nixos/home/home.nix
				/etc/nixos/home/graphical/graphical.nix
			];
		}
	;
}
