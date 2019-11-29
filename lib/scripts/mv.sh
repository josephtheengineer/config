function main
{
	arg=false
	if [[ $1 == '-'* ]]; then
		arg=true
	fi

	echo "Preparing to move: "
	if [[ "$arg" = true ]]; then
		if [ -d "$2" ]; then
			echo "$(tree -aC $2)"
		else
			echo $2
		fi
	else
		if [ -d "$1" ]; then
			echo "$(tree -aC $1)"
		else
			echo $1
		fi
	fi

	echo -n "Is this ok? [Y/n]: "
	read response
	case "$response" in
		[nN][oO]|[nN])
			return 1
			;;
		*)
			mv "$@" & progress -mp $!
			;;
	esac
}

main "$@"
