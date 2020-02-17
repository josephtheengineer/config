mount_drive=$LIB/scripts/mount-drive.sh

$mount_drive -ed /dev/disk/by-uuid/cc113da8-7801-4980-9aff-44f34dc15999 -p /mnt/data
$mount_drive -ed /dev/disk/by-uuid/689d84f1-0781-4b2e-9430-df1b4e51e371 -p /mnt/media
$mount_drive -ed /dev/disk/by-uuid/69a18ba2-ba12-4aa6-b4c6-c7967ecbd397 -p /mnt/backup
