date=$(date +%Y-%m-%d)
journal="$HOME/workspace/josephtheengineer.ddns.net/journal"

# Check / setup daily workspace
if [ ! -d "$journal/$date" ]; then
	echo wow
	mkdir -p "$journal/$date";
	echo "# $date" >> "$journal/$date/todo.md"
fi

case $1 in
	add)
		echo "\"- "$2" $3 "to" $4\"" >> "$journal/$date/todo.md"
	;;
	remove)
		echo "What task do you want to remove?"
		$XDG_CONFIG_HOME/scripts/todo.sh tasks
		read input

		find="- \"$input"
		sed -i "/$find/d" "$journal/$date/todo.md"	
	;;
	complete)
		echo "What task to you want to complete?"
		$XDG_CONFIG_HOME/scripts/todo.sh tasks
		read input
		find="- \"$input"
		replace="+ \"$input"

		sed -i -e "s/$find/$replace/" "$journal/$date/todo.md"
	;;
	refresh)
		file="$journal/$date/todo.md"
		while IFS=: read -r f1 f2 f3 f4 f5 f6 f7
		do
			if [ $f1 == "-" ]; then
				#if [ $f5 ]
			fi
		done <"$file"
	;;
	current)

	;;
	tasks)
		case $2 in
			--all)
				cat $journal/$date/todo.md
	
			;;
			--failed)
				cat $journal/$date/todo.md | grep -i "^x"
	
			;;
			--completed)
				cat $journal/$date/todo.md | grep -i "^+"

			;;
			*)
				cat $journal/$date/todo.md | grep -i "^-"
			;;
		esac	
	;;
esac
