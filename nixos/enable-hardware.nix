{ config, pkgs, ... }:
{
	hardware = {
		# Legacy applications
		opengl.driSupport32Bit = true;
		opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		pulseaudio.support32Bit = true;

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
