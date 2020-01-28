function main {
	echo "Setting niceness..."
	array=$(pgrep sway)

	for i in "${array[@]}"
	do
		ps -p $i
		sudo renice -n -15 -p $i
	done
}

main $@
