{ config, pkgs, ... }:
{
	programs = {
		dconf.enable = true;
		light.enable = true;
		sway.enable = true;
	};
}
