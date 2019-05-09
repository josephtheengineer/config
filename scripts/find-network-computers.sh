#$connected = shell_exec('ping -c1 8.8.8.8 2> /dev/null && echo "true" || echo "false"');

#ping -b 192.168.207.255
echo "Broadcast address must be pinged!"

x=0
y=0
while [ $x -le 255 ]; 
do
	while [ $y -le 255 ];
		do
			echo "Pinging 192.168.$x.$y"
			ping -c 1 -W 1 192.168.$x.$y | grep 'from';
			y=$(( $y + 1 ))
		done
	x=$(( $x + 1 ))
done

echo "Ping scan complete!"
ip neighbor show
