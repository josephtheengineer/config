function main {
	# First obtain a location code from: https://weather.codes/search/
	location="ASXX0016"
	fetch=false

	check $@

	if [[ $fetch = true ]]; then
		fetch_times
	fi
	calcuate_time

	exit 1
}

function check {
	local OPTIND opt
	while getopts ":l:f" opt; do
		case $opt in
			l) location=$OPTARG;;
			f) fetch=true;;
			\?h) help;exit 1;;
		esac
	done
	shift $((OPTIND -1))
}

function fetch_times {
	mkdir -p "$CACHE/solar-time"

	# Obtain sunrise and sunset raw data from weather.com
	sun_times=$( lynx --dump  https://weather.com/weather/today/l/$location | grep "\* Sun" | sed "s/[[:alpha:]]//g;s/*//" )

	# Alternative curl/wget solution.
	#sun_times=$( curl -s  https://weather.com/weather/today/l/$location | sed 's/<span/\n/g' | sed 's/<\/span>/\n/g'
	#	| grep -E "dp0-details-sunrise|dp0-details-sunset" | tr -d '\n' | sed 's/>/ /g' | cut -d " " -f 4,8 )

	#sun_times=$( wget -qO-  https://weather.com/weather/today/l/$location | sed 's/<span/\n/g'
	#	| sed 's/<\/span>/\n/g'  | grep -E "dp0-details-sunrise|dp0-details-sunset" | tr -d '\n' | sed 's/>/ /g' | cut -d " " -f 4,8 )

	# Extract sunrise and sunset times and convert to 24 hour format
	sunrise=$(date --date="`echo $sun_times | awk '{ print $1}'` AM" +%R)
	sunset=$(date --date="`echo $sun_times | awk '{ print $2}'` PM" +%R)

	echo $sunrise > "$CACHE/solar-time/sunrise"
	echo $sunset > "$CACHE/solar-time/sunset"

	#echo "Sunrise for location $location: $sunrise"
	#echo "Sunset for location $location: $sunset"
}

function calcuate_time {
	#echo "Current local time: $(date)"
	#echo "Current UTC time: $(date -u)"

	#echo "Decimal hours: $(echo "00:20:40.25" | awk -F: '{ print $1 + ($2/60) + ($3/3600) }')"

	sunrise="$(<$CACHE/solar-time/sunrise)"
	sunset="$(<$CACHE/solar-time/sunset)"


	sunrise_sec=$(echo $sunrise | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
	sunset_sec=$(echo $sunset | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')
	localtime_sec=$(echo $(date +'%H:%M:%S') | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')

	#echo "Sunrise sec: $sunrise_sec"
	#echo "Sunset sec: $sunset_sec"
	#echo "Local sec: $localtime_sec"

	day_diff=$(($sunset_sec - $localtime_sec))
	night_diff=$((($sunrise_sec + 24*60*60) - $localtime_sec))

	#echo "Day diff: $day_diff"


	if (( $day_diff > 0 )); then
		echo "+$(convertsecs $day_diff) SOL+BRIS"
	else
		echo "-$(convertsecs $night_diff) SOL+BRIS"
	fi
}

function convertsecs {
	((h=${1}/3600))
	((m=(${1}%3600)/60))
	((s=${1}%60))
	printf "%02d:%02d:%02d\n" $h $m $s
}

main $@
