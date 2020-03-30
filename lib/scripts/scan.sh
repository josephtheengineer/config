function main { # args
	date="$(date +%Y%m%d%H%M%S)Z"
	correspondent="$USER"
	name="scan"
	tags=""
	format="png"
	resolution="300"

	check "$@"

	if [[ $tags == *" "* ]]; then
		echo "Error: Tags field contains a space"
		exit 1
	fi

	scan "$date" "$correspondent" "$name" "$tags" "$format" "$resolution"

	exit 1
}

function check { # args
	local OPTIND opt
	while getopts ":d:c:n:t:f:r:h" opt; do
		case $woah in *"-"*)
			echo "Error: $opt contains '-'"
			exit 1
		;;esac
		case $opt in
			d) date=$OPTARG;;
			c) correspondent="$OPTARG";;
			n) name="$OPTARG";;
			t) tags="$OPTARG";;
			f) format="$OPTARG";;
			r) resolution="$OPTARG";;
			h) help; exit 0;;
			*) help; exit 1;;
		esac
	done

	if test $OPTIND -eq 1; then
		echo "Error: No options were passed"
		help; exit 1
	fi


	shift $((OPTIND -1))
}

function help {
	echo " -d (date) default = date +%Y%m%d%H%M%S Z
	-c (correspondent) default = \$USER
	-n (name) default = scan
	-t (tags)
	-f (format) default = png
	-r (resolution) default = 300
	"
}

function scan { # date, correspondent, name, tags, format, resolution
	filename=""

	if [ -z "$4" ]; then
		filename="/var/spool/scans/$1 - $2 - $3.$5"
	else
		filename="/var/spool/scans/$1 - $2 - $3 - $4.$5"
	fi

	sudo scanimage -p --format="$5" --resolution="$6" >$filename
}

main "$@"
