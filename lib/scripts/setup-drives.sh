mount_drive="$LIB/scripts/mount-drive.sh"

#$mount_drive -ed /dev/disk/by-uuid/cc113da8-7801-4980-9aff-44f34dc15999 -p /mnt/data
#$mount_drive -ed /dev/disk/by-uuid/689d84f1-0781-4b2e-9430-df1b4e51e371 -p /mnt/media
$mount_drive -ed /dev/disk/by-uuid/2a8ecca3-59b2-4ca0-ac37-c9f6b463e507 -p /mnt/backup -k "$(ssh -tq ssh.theengineer.life pass show drive/backup | head -n 1)"
