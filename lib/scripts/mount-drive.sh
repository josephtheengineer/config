function main {
	encrypted=false
	key=""
	drive=""
	path=""

	check $@

	mount "$drive" "$path" "$encrypted" "$key"

	exit 1
}

function check {
	local OPTIND opt
	while getopts ":ek:d:p:" opt; do
		case $opt in
			e) encrypted=true;;
			k) key="$OPTARG";;
			d) drive="$OPTARG";;
			p) path="$OPTARG";;
			\?h) help;exit 1;;
		esac
	done
	shift $((OPTIND -1))
}

function mount {
	drive=""
	if [ -z "$1" ]; then

		mountable=$(lsblk -lp | grep "part  $" | awk '{print $1, "(" $4 ")"}')

		[[ "$mountable" = "" ]] && exit 1

		echo "$mountable"
		echo "Mount drive:"

		read drive
	else
		drive=$1
	fi

	[[ "$drive" = "" ]] && exit 1
	#sudo mount "$drive" && exit 0

	mountpoint=""
	if [ -z "$2" ]; then
		dirs=$(find /mnt /home -type d -maxdepth 2 2>/dev/null)
		echo "$dirs"

		echo "Mount point:"
		read mountpoint
	else
		mountpoint=$2
	fi

	[[ "$mountpoint" = "" ]] && exit 1

	if [[ ! -d "$mountpoint" ]]; then
		echo "$mountpoint does not exist. Create it?"
		echo -e "n\ny"
		read mkdiryn
		[[ "$mkdiryn" = y ]] && sudo mkdir -p "$mountpoint"
	fi
	if [[ $3 = true ]]; then
		if [ -n "$4" ]; then
			printf "$4" | sudo cryptsetup open --type luks $drive $(basename $mountpoint) #${drive#"/dev/"}
		else
			sudo cryptsetup open --type luks $drive $(basename $mountpoint) #${drive#"/dev/"}
		fi
		sudo mount /dev/mapper/$(basename $mountpoint) $mountpoint && echo "$drive mounted to $mountpoint."
	else
		sudo mount $drive $mountpoint && echo "$drive mounted to $mountpoint."
	fi
}

main $@
