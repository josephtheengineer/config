{ config, pkgs, ... }:
{
	hardware = {
		pulseaudio.enable = true;
		bluetooth.enable = true;
		opengl.enable = true;
		opengl.driSupport = true;
	};
        sound.enable = true;

	services = {
		blueman.enable = true;
	};
}
