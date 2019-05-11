source $XDG_CONFIG_HOME/scripts/terminal-colors.sh

if [ ! -d ~/.local/share/system-status/ ]; then
  mkdir ~/.local/share/system-status
fi

internet_status="OFFLINE"
internet_info=""
genesis_status="OFFLINE"
genesis_info=""

function create_bar(){
	#if [[ -z $2 && -z $3]]
	if [[ -z $2 ]]; then
		percent=$1
	else
		percent=0
		if [[ $2 == 0 && $1 != 0 ]]; then
			percent=100
		elif [[ $1 == 0 ]]; then
			percent=0
		else
			total=$(($2+$1))
			percent=$((200*$1/$total % 2 + 100*$1/$total))
		fi
	fi

	bar=""
	for i in {1..10};
	do
		value=$((i * 10))
		if (( $percent > $value )); then
			bar=$bar"${green}=${reset}"
		else
			bar=$bar"="
		fi
	done
}

function server_status(){
	status="${red}OFFLINE${reset}"
	status_command=$(timeout 2 nmap $2 -PN -p ssh | grep open) 
	if [[ $status_command == "22/tcp open  ssh" ]]; then
		status="${green}ONLINE${reset}"
		echo "ONLINE" >> ~/.local/share/system-status/$1-uptime
		genesis_status="ONLINE"
	else
		echo "OFFLINE" >> ~/.local/share/system-status/$1-uptime
		genesis_status="OFFLINE"
	fi

	online=$(grep -r "ONLINE" ~/.local/share/system-status/$1-uptime | wc -l)
	offline=$(grep -r "OFFLINE" ~/.local/share/system-status/$1-uptime | wc -l)

	create_bar $online $offline

	genesis_info=("      $1: $status [$bar]$percent% uptime")
}

function internet_status(){
	internetq_status="${red}OFFLINE${reset}"
	ping -c 1 -W 1 $1 >/dev/null && internetq_status="${green}ONLINE${reset}" > /dev/null
	
	if grep -q "ONLINE" <<<"$internetq_status"; then
    		echo "ONLINE" >> ~/.local/share/system-status/$1-uptime
		internet_status="ONLINE"
	else
		echo "OFFLINE" >> ~/.local/share/system-status/$1-uptime
		internet_status="OFFLINE"
	fi
	
	online=$(grep -r "ONLINE" ~/.local/share/system-status/$1-uptime | wc -l)
	offline=$(grep -r "OFFLINE" ~/.local/share/system-status/$1-uptime | wc -l)
	
	create_bar $online $offline

	internet_info=("     internet: $internetq_status [$bar]$percent% uptime")

}

# =========================== Start ===================================

KERNEL_VERSION=$(uname -a | awk '{print $3}')
OS_VERSION=$(sed -n -e 6p /etc/*release* | awk '{gsub("PRETTY_NAME=", "");print}' | awk '{gsub("\"", "");print}')
SCRIPT="$XDG_CONFIG_HOME/scripts/"

art=$(toilet -d ~/.config/scripts/figlet-fonts -f Big.flf $(hostname) | grep -v -e '^[[:space:]]*$')
readarray -t art_array <<<"$art"
declare -a info

info+=("Welcome to Kernel $KERNEL_VERSION, $OS_VERSION.")
info+=("UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED!")

info+=("$(uptime | awk '{print $1, $2}') $(date)")

# =========================== Filesystems ==============================

FILESYSTEM_ROOT=$($SCRIPT/filesystem-status.sh | awk '{gsub("%", "");print}')

if [[ $FILESYSTEM_ROOT < 90 ]]; then
	info+=("${white}   Filesystems : ${green}OK${reset}")
	info+=("         Root: ${green}OK${reset} [=========]$FILESYSTEM_ROOT% free")
fi

# ========================== System Version =============================

if [[ true ]]; then
	info+=("${white}System Version : ${green}OK${reset}")
fi

# ========================= Config Version ==============================

if [[ true ]]; then
	info+=("${white}Config Version : ${green}OK${reset}")
fi

# ======================== Network Status  ==============================

internet_status archlinux.org
server_status genesis josephtheengineer.ddns.net

network_status="${red}UNAVAILABLE${reset}"

if [[ $internet_status == "ONLINE" && $genesis_status == "ONLINE" ]]; then
	network_status="${green}OK${reset}"
elif [[ $internet_status == "ONLINE" && $genesis_status == "OFFLINE" ]]; then
	network_status="${red}SSH OFFLINE${reset}"
fi

info+=("${white} Network Status: $network_status${reset}")
info+=("$internet_info")
info+=("$genesis_info")


# =====================================================================

info+=("${white}Services Status:${reset}")
info+=("       Update: Active")
info+=("         Sync: Inactive")

info+=("${white}Identity Status:${reset}")
info+=("     GPG Sign: unlocked, valid")
info+=("     Keychain: locked, valid")
#info+=("Last login Fri May 35 from 192.168.0.1")

#info+=("$(ls -C)")

num=0
for i in "${info[@]}"
do
	if [ ${art_array[num]+abc} ]; then
		echo -e "${art_array[num]}" "$i"
	else
		length=$((${#art_array[0]} - 1))
		for ((i=0;i<=$length;i++))
		do
			if (( $(( ( RANDOM % 4 )  + 0 )) == 0 )); then
				echo -ne $(( ( RANDOM % 9 )  + 0 ))
			else
				echo -ne " "
			fi
		done
		echo -e " ${info[num]}"
	fi
	num=$((num+1))
done
