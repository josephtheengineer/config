BKUP_LOC="/mnt/backup/axius"

rm -rf "$(BKUP_LOC)/backup.3"
mv "$(BKUP_LOC)/backup.2" "$(BKUP_LOC)/backup.3"
mv "$(BKUP_LOC)/backup.1" "$(BKUP_LOC)/backup.2"
mv "$(BKUP_LOC)/backup.0" "$(BKUP_LOC)/backup.1"

sudo rsync -aAXv --delete --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude="cache" --link-dest=$(BKUP_LOC)/backup.1 /  $(BKUP_LOC)/backup.0
