{ config, pkgs, ... }:

{
	services.nginx = {
 		enable = true;
 		statusPage = true;
 		virtualHosts."www.theengineer.life" = {
			#addSSL = true;
			#enableACME = true;
			#index index.html;
			#autoindex on;
			root = "/srv/www/theengineer.life";
			listen = [ { addr = "*"; port = 8787; } ];
		};
		#virtualHosts."eco.theengineer.life" = {
			#globalRedirect = "elicox.tech";
		#};
	};
}
