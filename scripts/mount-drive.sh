function main {
	encrypted=false
	drive=""
	path=""

	check $@

	mount "$drive" "$path" "$encrypted"

	exit 1
}

function check {
	local OPTIND opt
	while getopts ":ed:p:" opt; do
		case $opt in
			e) encrypted=true;;
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
		sudo cryptsetup luksOpen $drive ${drive#"/dev/"}
		sudo mount /dev/mapper/${drive#"/dev/"} $mountpoint && echo "$drive mounted to $mountpoint."
	else
		sudo mount $drive $mountpoint && echo "$drive mounted to $mountpoint."
	fi
}

main $@
