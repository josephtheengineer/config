function main {
	verbose=false
	path=""

	check $@

	echo "Starting Infinity..."
	zsh
	#tick
	exit 1
}

function check {
        local OPTIND opt
        while getopts ":vp:" opt; do
                case $opt in
                        e) verbose=true;;
                        p) path="$OPTARG";;
                        \?h) help;exit 1;;
                esac
        done
        shift $((OPTIND -1))
}

function tick {
	echo "Starting Service..."
	while sleep 1; do echo $(date) " OK"; done
}

main $@
