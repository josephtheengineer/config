function main
{
	directory=false
	arg=false
	if [[ $1 == '-'* ]]; then
		arg=true
	fi

	if [[ -d $1 && $arg = false ]]; then
		echo -n "$1 is a directory, Do you still want to move? [Y/n]: "
		read response
		case "$response" in
			[nN][oO]|[nN])
				return 1
				;;
			*)
				directory=true
				;;
		esac
	fi

	echo "Preparing to move: "
	if [[ "$arg" = true ]]; then
		if [ -d $2 ]; then
			echo "$(tree -aC $2)"
		else
			echo $2
		fi
	else
		if [ -d $1 ]; then
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
			if [ "$directory" = true ]; then
				mv -r $@ & progress -mp $!
			else
				mv $@ & progress -mp $!
			fi
			;;
	esac
}

main $@
