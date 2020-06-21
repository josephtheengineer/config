{ config, pkgs, ... }:
{
	networking.hostName = "yoshi";
	imports = [
		./systemd-boot.nix
		./packages.nix
		./graphical-packages.nix
		./enable-hardware.nix
		./printing.nix
		./graphical-environment.nix
	];
}
