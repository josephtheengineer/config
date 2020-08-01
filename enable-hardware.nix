{ config, pkgs, ... }:
{
	hardware = {
		# Legacy applications
		opengl.driSupport32Bit = true;
		opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
		opengl.extraPackages = with pkgs; [ amdvlk libva ];
		pulseaudio.support32Bit = true;

		pulseaudio.enable = true;
		bluetooth.enable = true;
		opengl.enable = true;
		opengl.driSupport = true;
	};
        sound.enable = true;

	environment.systemPackages = with pkgs; [
		vulkan-headers
		vulkan-loader
		vulkan-tools
		vulkan-validation-layers
	];

	services = {
		blueman.enable = true;
	};
}
