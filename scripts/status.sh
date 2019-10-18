SINK=0

while echo "Volume:" $volume " | " $date "UTC$timezone"
	do sleep 1
	volume=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,')

	date=$(date +'%Y-%m-%d %H:%M:%S')
	timezone=$(date +%:::z)
done
