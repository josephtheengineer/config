{ config, pkgs, ... }:
{
	programs.kitty = {
		enable = true;
		font.name = "Noto Mono for Powerline";
		settings = {
			symbol_map = "U+2800-U+28FF Noto Sans Symbols2";
			foreground = "#44525d";
			background = "#0e1821";
			background_opacity = "0.5";
			window_padding_width = 10;
			font_size = 9;
		};
	};
}
