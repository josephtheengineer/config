if [ ! -d ~/.cache/workspaces ]; then
	mkdir ~/.cache/workspaces
fi

typeset -i current=1
typeset -i current=$(cat ~/.cache/workspaces/current)
typeset -i mode=0

function switch {
	  echo "Switching workspace..."
    echo $1
    typeset -i current=$(cat ~/.cache/workspace/current)
    typeset -i last_mode=$(cat ~/.cache/workspaces/$current)
    echo $1 > ~/.cache/workspaces/current
    typeset -i mode=$(cat ~/.cache/workspaces/$1)
		
	if [ $last_mode != $mode ]; then
		killall conky
		sleep 0.05
		case $mode in
		1)
			  # Right panel
        conky -c ~/config/conky-right.conf
        sleep 0.05
        swaymsg workspace $1
        swaymsg gaps right current set 400
		;;
		2)
			  # Left panel
        conky -c ~/config/conky-left.conf
        sleep 0.05
        swaymsg workspace $1
        swaymsg gaps left current set 400
		;;
		3)
			  # Both panels
        conky -c ~/config/conky-right.conf
        conky -c ~/config/conky-left.conf
        sleep 0.05
        swaymsg workspace $1
        swaymsg gaps right current set 400
        swaymsg gaps left current set 400
		;;
		0)
        swaymsg workspace $1
        swaymsg gaps right current set 0
        swaymsg gaps left current set 0
        echo "0"
		;;
		*)
			echo "error"
		;;
			esac
  else
      swaymsg workspace $1
  fi
}

case $1 in 
	switch)
		switch $2
	;;
	set-mode)
		echo "Seting mode..."
		typeset -i mode=$(cat ~/.cache/workspaces/$current)
		echo "Setting the mode of workspace: "
		echo $current

		if [ $2 == "right" ]; then
			case $mode in
				0)
					echo "Setting mode to 1..."
					swaymsg gaps right current set 400
					echo 1 > ~/.cache/workspaces/$current
				;;
				1)
					echo "Setting mode to 0..."
					swaymsg gaps right current set 0
					echo 0 > ~/.cache/workspaces/$current
				;;
				2)
					echo "Setting mode to 3..."
					swaymsg gaps right current set 400
					echo 3 > ~/.cache/workspaces/$current
				;;
				3)
					echo "Setting mode to 2..."
					swaymsg gaps right current set 0
					echo 3 > ~/.cache/workspaces/$current
				;;
			esac
		else
				case $mode in
				    0)
					      echo "Setting mode to 2..."
					      swaymsg gaps left current set 400
					      echo 2 > ~/.cache/workspaces/$current
				        ;;
				    1)
					      echo "Setting mode to 3..."
					      swaymsg gaps left current set 400
					      echo 3 > ~/.cache/workspaces/$current
				        ;;
				    2)
					      echo "Setting mode to 0..."
					      swaymsg gaps left current set 0
					      echo 0 > ~/.cache/workspaces/$current
				        ;;
				    3)
					      echo "Setting mode to 1..."
					      swaymsg gaps left current set 0
					      echo 1 > ~/.cache/workspaces/$current
				        ;;
			  esac
		fi

		sleep 0.05
		switch $current
	;;
	*)
		echo "error: invalid usage"
		echo "workspace-manager switch 1"
		echo "workspace-manager set-mode 0"
		echo "0 == fullscreen"
		echo "1 == right panel shown"
		echo "2 == left panel shown"
		echo "3 == both panels shown"
	;;
esac
