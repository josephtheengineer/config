{ config, pkgs, ... }:
{
	boot.loader = {
		grub.enable = false;
		# Use the systemd-boot EFI boot loader.
		systemd-boot.enable = true;
		efi.canTouchEfiVariables = true;
	};
}
