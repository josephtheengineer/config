{ config, pkgs, ... }:

{
	services.nginx = {
 		enable = true;
 		statusPage = true;
 		virtualHosts."www.theengineer.life" = {
			addSSL = true;
			enableACME = true;
			root = "/srv/www/theengineer.life";
			#listen = [ { addr = "*"; port = 8787; } ];
		};
		#virtualHosts."www.theengineer.life" = {
		#	globalRedirect = "genesis.theengineer.life";
		#};
	};
}
