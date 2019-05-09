KERNEL_VERSION=$(uname -a | awk '{print $3}')
OS_VERSION=$(sed -n -e 6p /etc/*release* | awk '{gsub("PRETTY_NAME=", "");print}' | awk '{gsub("\"", "");print}')
SCRIPT="$XDG_CONFIG_HOME/scripts/"

echo Welcome to Kernel $KERNEL_VERSION, $OS_VERSION
figlet $(hostname)
date

FILESYSTEM_ROOT=$($SCRIPT/filesystem-status.sh | awk '{gsub("%", "");print}')

if [[ $FILESYSTEM_ROOT < 90 ]]; then
	echo "Filesystems : OK"
	echo "	Root - $FILESYSTEM_ROOT%"
fi

if [[ true ]]; then
	echo "System Version : OK"
	echo ""
fi

if [[ true ]]; then
	echo "Config Version : OK"
	echo ""
fi

echo "Network Status"
echo "	Genesis: OFFLINE [========]0% Uptime"

echo "Services Status:"
echo "Update: Active"
echo "Sync: Inactive"

echo "Identity Status:"
echo "GPG Sign: unlocked, valid"
echo "Keychain locked, valid"
echo "Last login Fri May 35 from 192.168.0.1"

ls
