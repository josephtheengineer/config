{ config, pkgs, ... }:
{
	programs.zathura = {
		enable = true;
		extraConfig = ''
			map i recolor
			map p print
		'';
	};
}
