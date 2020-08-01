{ config, pkgs, ... }:
{
	programs.neovim = {
		enable = true;
		withPython = false;
		withPython3 = false;
		withRuby = false;
		plugins = with pkgs.vimPlugins; [
			#surround
			nerdtree
			goyo
			vimwiki
			airline
			commentary
			sensible
			calendar
			syntastic
			#vim-nix
			# vim-gdscript3
		];
		extraConfig = builtins.readFile ./init.vim;
	};
}
