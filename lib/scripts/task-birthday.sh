function main { # args
	message=""
	date=""

	check "$@"

	birthday "$message" "$date"
}

function check { # args
	local OPTIND opt
	while getopts ":m:d:h" opt; do
		case $opt in
			m) message=$OPTARG;;
			d) date="$OPTARG";;
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
	echo " -m message
	-d date
	"
}

function birthday { # message, date
	task add +birthday $1 \
		due:$2 \
		scheduled:due-4d \
		wait:due-7d \
		until:due+2d \
		recur:yearly
}
main "$@"
