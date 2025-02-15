opts: import ../lib/mk-tracker-blocker.nix {
	name = "netlify";
	extraConfig = {
		home.shellAliases = {
			netlify = "netlify --telemetry-disable";
		};
	};
} opts
