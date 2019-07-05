date=$(date +%Y-%m-%d)
journal="$HOME/workspace/josephtheengineer.ddns.net/journal"

# Check / setup daily workspace
if [ ! -d "$journal/$date" ]; then
        echo wow
        mkdir -p "$journal/$date";
        echo "# $date" >> "$journal/$date/tasks.md"
fi

function startup {
	echo "Good morning, $USER"
	sleep 1
	echo "The current time is $(date +%H:%M\ on\ %A\ the\ %d\ %B)"
	sleep 1
	minute=$(date +%M)
	hour=$(date +%H)
	
	totalmin=$((($hour*60+$minute)))
	
	minleft=$(((20*60-$totalmin)))

	echo "You currently have $minleft minutes left today"
	sleep 2
	echo "How much sleep did you get last night? (hours)"
	read input

	echo "How good did you sleep last night? (0-100)"
	read input

	echo "Did you complete meditiation before going to bed? (y/n)"
	read input

	echo " ============ Tasks ============"

	echo "What is your most important task today?"
	read input

	echo "Do you have another task you want to do today?"
	read input

	echo "Another task?"
	read input

	echo "Any more todo list items?"
	read input

	echo " ============ Half hour tasks ============"

	echo " ============ 10 minute tasks ============"


	


}

case $1 in
	-s)
		startup
	;;
esac


