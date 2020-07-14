{ config, pkgs, ... }:
{
	programs.qutebrowser = {
		enable = true;
		settings = {
			content.host_blocking.enabled = true;
			downloads.location.directory = "~/downloads";
		};
	};
}
