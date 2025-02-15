opts: import ../lib/mk-tracker-blocker.nix {
	name = "gatsby";
	envKey = "GATSBY_TELEMETRY_DISABLED";
} opts
