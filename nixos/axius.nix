{ config, pkgs, ... }:
{
	networking.hostName = "axius";
	imports = [
		./systemd-boot.nix
		./packages.nix
		./graphical-packages.nix
		./encrypted-boot.nix
		./enable-hardware.nix
		./printing.nix
		./graphical-environment.nix
	];
}
