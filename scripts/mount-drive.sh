mountable=$(lsblk -lp | grep "part  $" | awk '{print $1, "(" $4 ")"}')

[[ "$mountable" = "" ]] && exit 1

echo "$mountable"
echo "Mount drive:"

read chosen

[[ "$chosen" = "" ]] && exit 1
sudo mount "$chosen" && exit 0

dirs=$(find /mnt /home -type d -maxdepth 2 2>/dev/null)
echo "$dirs"

echo "Mount point:"
read mountpoint
[[ "$mountpoint" = "" ]] && exit 1

if [[ ! -d "$mountpoint" ]]; then
	echo "$mountpoint does not exist. Create it?"
	echo -e "n\ny"
	read mkdiryn
	[[ "$mkdiryn" = y ]] && sudo mkdir -p "$mountpoint"
fi
if [[ $1 = "-e" ]]; then
	sudo cryptsetup luksOpen $chosen ${chosen#"/dev/"}
	sudo mount /dev/mapper/${chosen#"/dev/"} $mountpoint && echo "$chosen mounted to $mountpoint."
else
	sudo mount $chosen $mountpoint && echo "$chosen mounted to $mountpoint."
fi
