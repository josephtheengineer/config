{ config, pkgs, ... }:
let
	PRIMARYUSBID = "3a984ec3-a9aa-40c8-b984-d2cf177bdbcb";
	BACKUPUSBID = "CE80-0D27";
in {
	boot.initrd.kernelModules = [ "uas" "usbcore" "usb_storage" "vfat" "nls_cp437" "nls_iso8859_1" ];
	boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
		mkdir -m 0755 -p /mnt/keys
		sleep 5
		mount -n -t ext4 -o ro `findfs UUID=3a984ec3-a9aa-40c8-b984-d2cf177bdbcb` /mnt/keys || mount -n -t vfat -o ro `findfs UUID=CE80-0D27` /mnt/keys
	'';
	boot.initrd.luks.devices."root" = {
		keyFile = "/mnt/keys/" + config.networking.hostName;
		preLVM = false;
	};
}
