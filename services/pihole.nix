{ config, pkgs, ... }:

{
	docker-containers.pihole = {
		image = "pihole/pihole:latest";
		ports = [
			"5353:53/tcp"
			"5353:53/udp"
			"67:67/udp"
			"8088:80"
			"4433:443"
		];
		volumes = [
			"/var/lib/pihole/:/etc/pihole/"
			"/var/lib/dnsmasq/.d:/etc/dnsmasq.d/"
		];
		environment = {
			#ServerIP = serverIP;
		};
		extraDockerOptions = [
			"--cap-add=NET_ADMIN"
			"--dns=127.0.0.1"
 			"--dns=1.1.1.1"
		];
		workdir = "/var/lib/pihole/";
	};
}
