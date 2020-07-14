{ config, pkgs, ... }:

{

	security = {
		acme = {
			acceptTerms = true;
			email = "acme@theengineer.life";
		};
	};

	services.nginx = {
 		enable = true;
 		statusPage = true;
		sslProtocols = "TLSv1.3"
		upstreams.journal.servers."127.0.0.1:3000" = {};
 		virtualHosts."www.theengineer.life" = {
			#addSSL = true;
			forceSSL = true;
			enableACME = true;
			root = "/srv/www/theengineer.life";
			#listen = [ { addr = "*"; port = 8787; } ];
		};
		virtualHosts."journal.theengineer.life" = {
			#addSSL = true;
			forceSSL = true;
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
		virtualHosts."cache.theengineer.life" = {
			serverAliases = [ "cache" ];
			locations."/".extraConfig = ''
				proxy_pass http://10.0.0.11:5000;
				proxy_set_header Host $host;
				proxy_set_header X-Real-IP $remote_addr;
				proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
			'';
		};
		appendHttpConfig = ''
			error_page 404 /error/404.html;
		'';
	};
}
