mount_drive=~/.config/scripts/mount-drive.sh

$mount_drive -ed /dev/disk/by-uuid/03e25565-533a-4718-bde9-f5b68595c978 -p backup
$mount_drive -ed /dev/disk/by-uuid/689d84f1-0781-4b2e-9430-df1b4e51e371 -p media
$mount_drive -ed /dev/disk/by-uuid/cc113da8-7801-4980-9aff-44f34dc15999 -p data
