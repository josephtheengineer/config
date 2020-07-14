{ config, pkgs, ... }:

{
	users.users.git = {
		isSystemUser = true;
		home = "/srv/git";
		description = "git access";
		extraGroups = [ "website-dev" ];
		shell = "/run/current-system/sw/bin/git-shell";
	};
}
