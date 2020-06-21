{ config, pkgs, ... }:

{
	services.nginx = {
 		enable = true;
 		statusPage = true;
		upstreams.journal.servers."127.0.0.1:3000" = {};
 		virtualHosts."www.theengineer.life" = {
			addSSL = true;
			#forceSSL= true;
			enableACME = true;
			root = "/srv/www/theengineer.life";
			#listen = [ { addr = "*"; port = 8787; } ];
		};
		virtualHosts."journal.theengineer.life" = {
			addSSL = true;
			enableACME = true;
			#root = "/var/journal/theengineer.life";
			locations."/".extraConfig = ''
				#proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
				#proxy_set_header Host $http_host;
				proxy_pass http://journal;
			'';
		};
		#virtualHosts."www.theengineer.life" = {
		#	globalRedirect = "genesis.theengineer.life";
		#};

		appendHttpConfig = ''
			error_page 404 /error/404.html;
		'';
	};
}
