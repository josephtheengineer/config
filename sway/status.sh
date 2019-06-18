$volume = $(pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

$date = $(date +'%Y-%m-%d %l:%M:%S %p')

while true
	do sleep 1
	$date $volume
done
