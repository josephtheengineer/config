SINK=0

net="disconnected"
vol=0
date="0000-00-00 00:00:00"

while echo " net:$net | vol: $vol | $date UTC$timezone"
	do sleep 1
	vol=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

	date=$(date +'%Y-%m-%d %H:%M:%S')
	timezone=$(date +%:::z)
	net=$(nmcli | head -n 1 | awk '!($1="")' | awk '!($1="")' | awk '!($1="")')
done
