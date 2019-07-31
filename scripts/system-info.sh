source $XDG_CONFIG_HOME/scripts/terminal-colors.sh

if [ ! -d ~/.local/share/system-status/ ]; then
  mkdir ~/.local/share/system-status
fi

num=0
art=$(toilet -d ~/.config/scripts/figlet-fonts -f Big.flf $(echo $HOSTNAME) | grep -v -e '^[[:space:]]*$')
readarray -t art_array <<<"$art"
declare -a info

internet_status="OFFLINE"
internet_info=""
genesis_status="OFFLINE"
genesis_info=""

function create_bar {
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
		if [ $percent -gt $value ] || [ $percent -eq 100 ]; then
			if [[ $3 == "red" ]]; then
				bar=$bar"${red}=${reset}"
			else
				bar=$bar"${green}=${reset}"
			fi
		else
			bar=$bar"="
		fi
	done
}

function server_status {
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

function internet_status {
	internetq_status="${red}OFFLINE${reset}"
	ping_command=$(ping -c 1 -w 1 $1)

	# ping -c 1 -W 1 $1 > /dev/null && internetq_status="${green}ONLINE${reset}" > /dev/null
		
	if grep -q "time=" <<<"$ping_command"; then
    		echo "ONLINE" >> ~/.local/share/system-status/$1-uptime
		internetq_status="${green}ONLINE${reset}"
		internet_status="ONLINE"
	elif grep -q "Packet filtered" <<<"$ping_command"; then
		echo "ONLINE" >> ~/.local/share/system-status/$1-uptime
		internetq_status="${yellow}FILTERED${reset}"
		internet_status="FILTERED"
	else
		echo "OFFLINE" >> ~/.local/share/system-status/$1-uptime
		internet_status="OFFLINE"
	fi
	
	online=$(grep -r "ONLINE" ~/.local/share/system-status/$1-uptime | wc -l)
	offline=$(grep -r "OFFLINE" ~/.local/share/system-status/$1-uptime | wc -l)
	
	create_bar $online $offline

	internet_info=("     internet: $internetq_status [$bar]$percent% uptime")

}

function output {
	if [ ${art_array[num]+abc} ]; then
		echo -e "${art_array[num]}" "$1"
        else
                length=$((${#art_array[0]} - 1))
                for ((i=0; i<=$length; i++))
                do
                       	if (( $(( ( RANDOM % 4 )  + 0 )) == 0 )); then
                               	echo -ne $(( ( RANDOM % 9 )  + 0 ))
                       	else
                               	echo -ne " "
                       	fi
		done
        	        echo -e " $1"
	fi
        num=$((num+1))
}

# =========================== Start ===================================

KERNEL_VERSION=$(uname -a | awk '{print $3}')
OS_VERSION=$(sed -n -e 6p /etc/*release* | awk '{gsub("PRETTY_NAME=", "");print}' | awk '{gsub("\"", "");print}')
SCRIPT="$XDG_CONFIG_HOME/scripts/"

output "Welcome to Kernel $KERNEL_VERSION, $OS_VERSION."
output "UNAUTHORIZED ACCESS TO THIS DEVICE IS PROHIBITED!"

output "$(uptime | awk '{print $1, $2}') $(date)"

# ========================== System Version =============================
          
if [[ true ]]; then
        output "${white} System Version: ${green}OK${reset}"
fi

# ========================= Config Version ==============================

if [[ true ]]; then
        output "${white} Config Version: ${green}OK${reset}"
fi    

# ============================ Power ====================================

bat_status=$(acpi -i 2>/dev/null)

bat_percent=$(echo $bat_status | sed -n 1p | awk '{print $4}' | rev | cut -c 3- | rev)
bat_name=$(echo $bat_status | sed -n 1p | awk '{print $1, $2}')   
bat_charging_status=$(echo $bat_status | sed -n 1p | awk '{print $3}')
bat_remaining=$(echo $bat_status | sed -n 1p | awk '{print $5}')

power_status="${red}Low${reset}"

if [ -z "$bat_status" ]; then
	power_status="${green}OK${reset}"	
else
	if [[ $bat_status > 20 ]]; then
		if [[ $bat_charging_status = "Discharging," ]]; then
			power_status="${yellow}DISCHARGING"${reset}
		else
			power_status="${green}OK${reset}"
		fi
	else
		power_status="${red}Low${reset}"
	fi

	output "$white   Power Status: $power_status"
	create_bar $bat_percent
	output "    $bat_name $power_status [$bar]$bat_percent% full, $bat_remaining remaining"
fi


# ============================ Filesystems ==============================

filesystem_root=$(df -k . | sed -n 2p | awk '{print $5}' | awk '{gsub("%", "");print}')

if [[ $filesystem_root < 90 ]]; then
	output "${white}    Filesystems: ${green}OK${reset}"
	create_bar $filesystem_root $(((100-$filesystem_root)))
	output "         Root: ${green}OK${reset} [$bar]$filesystem_root% free"
fi

# ======================= Network Status  ==============================

internet_status archlinux.org
server_status genesis josephtheengineer.ddns.net

network_status="${red}UNAVAILABLE${reset}"

if [[ $internet_status == "ONLINE" && $genesis_status == "ONLINE" ]]; then
	network_status="${green}OK${reset}"
elif [[ $internet_status == "ONLINE" && $genesis_status == "OFFLINE" ]]; then
	network_status="${red}SSH OFFLINE${reset}"
elif [[ $internet_status == "FILTERED" && $genesis_status == "OFFLINE" ]]; then
        network_status="${red}FILTERED // SSH OFFLINE${reset}"
elif [[ $internet_status == "FILTERED" && $genesis_status == "ONLINE" ]]; then
        network_status="${yellow}FILTERED${reset}"
fi

output "${white} Network Status: $network_status${reset}"
output "$internet_info"
output "$genesis_info"


# =====================================================================

output "${white}Services Status:${reset}"

infinity_status="${red}Inactive${reset}"

if ps ax | grep -v grep | grep "sh .config/scripts/infinity.sh" > /dev/null; then
	infinity_status="${green}Active${reset}"
fi

output "     Infinity: $infinity_status"

nixos_status="Inactive"

if ps ax | grep -v grep | grep "nixos" > /dev/null; then
        nixos_status="${green}Active${reset}"
fi

output "          Nix: $nixos_status"
output "         Sync: Inactive"

output "${white}Identity Status:${reset}"
output "     GPG Sign: unlocked, valid"
output "     Keychain: locked, valid"
#output "Last login Fri May 35 from 192.168.0.1"

#output "$(ls -C)"
