function main {
	SINK=0

	net="disconnected"
	vol=0
	date="0000-00-00 00:00:00"
	solar="00:00:00 SUN+BRIS"
	tai="0000-00-00 00:00:00 TAI"

	display
}

function display {
	echo "net:$net | vol: $vol | $solar | $tai | $date UTC$timezone"

	vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

	solar=$($LIB/scripts/solar-time.sh)
	tai=$($LIB/scripts/atomic-time.sh)

	date=$(date +'%H:%M:%S')
	timezone=$(date +%:::z)
	net=$(nmcli | head -n 1 | awk '!($1="")' | awk '!($1="")' | awk '!($1="")')
	reload_on date
}

function reload_on {
	current=$1
	while [ "$1" = "$current" ]
	do
		sleep 0.1
		current=$(date +'%H:%M:%S')
	done
	display
}

main $@
