{ config, pkgs, ... }:

{
	services = {
		oidentd = {
			enable = true;
		};
		ircdHybrid = {
			enable = true;
			adminEmail = "josephtheengineer@pm.me";
			serverName = "JosephTheEngineer's Cafe";
		};
	};
}
