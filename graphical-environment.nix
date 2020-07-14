{ config, pkgs, ... }:
{
	imports = [
		./graphical-packages.nix
	];

	programs = {
		dconf.enable = true;
		light.enable = true;
		sway.enable = true;
	};
}
