exclusionregex="\(/boot\|/home\|/\)$"
drives=$(lsblk -lp | grep "t  /" | grep -v "$exclusionregex" | awk '{print $1, "(" $4 ")", "on", $7}')

[[ "$drives" = "" ]] && exit
echo "$drives"
echo "Umount drive: "
read chosen
[[ "$chosen" = "" ]] && exit

sudo umount $chosen && echo "$chosen unmounted."
