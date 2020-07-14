{ config, pkgs, ... }:

{
	imports = [
		(builtins.fetchTarball {
			url = "https://gitlab.com/simple-nixos-mailserver/nixos-mailserver/-/archive/master/nixos-mailserver-master.tar.gz";
 		})
	];

	networking.firewall.allowedTCPPorts = [
		25  # Connnection
		465 # Secure SMTP (Outbound mail)
		993 # Secure IMAP
		587 # Submission port (SMTP Secondary Route)
		23  # Telnet
];

	mailserver = {
		enable = true;
		fqdn = "genesis.theengineer.life";
		domains = [ "theengineer.life" ];

		# A list of all login accounts. To create the password hashes, use
		# mkpasswd -m sha-512 "password"
		loginAccounts = {
			"joseph@theengineer.life" = {
				hashedPassword = "$6$NHkCC3H/lr99Jnvt$HdY15Ne9eJ6DNrNf.Q25FqQi9V2gOfd7UeU.RNVLUibK5FY2N13JI3JCev4NmJ11nMyLKZnGQbA0m86xNUL5i.";

				aliases = [
					"postmaster@theengineer.life"
					"stumpy@theengineer.life"
					"agentatlas@theengineer.life"
				];

				# Make this user the catchAll address for domains below
				catchAll = [
					"theengineer.life"
				];
			};
			"eli@theengineer.life" = {
				hashedPassword = "$6$BcsnEIsbrHox.$bzClKiEefe11YlrVt/yhXDlGVpy6bzu1bE3kFEDz08r/jD1yyvSyUaoaQDYkVl54gx6xzd0p7i21QFXV/JjpC.";

				aliases = [
					"knighteco@theengineer.life"
					"eco@theengineer.life"
				];
			};
		};

		# Extra virtual aliases. These are email addresses that are forwarded
		extraVirtualAliases = {
			# address = forward address;
			"abuse@theengineer.life" = "joseph@theengineer.life";
			"dmarc@theengineer.life" = "joseph@theengineer.life";
			"forensics@theengineer.life" = "joseph@theengineer.life";
			"acme@theengineer.life" = "joseph@theengineer.life";
		};

		# Use Let's Encrypt certs. Note that this needs to set up a stripped down
		# nginx and opens port 80.
		certificateScheme = 3;

		# Enable IMAP and POP3
		enableImap = true;
		enablePop3 = true;
		enableImapSsl = true;
		enablePop3Ssl = true;

		# Enable the ManageSieve protocol
		enableManageSieve = true;

		virusScanning = true;
	};
}
