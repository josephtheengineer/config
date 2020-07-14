{ config, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		nodejs
		ddclient
		gnupg
		pinentry
	];
}
