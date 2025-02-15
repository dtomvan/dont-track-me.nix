opts: import ../lib/mk-tracker-blocker.nix {
	name = "awssam";
	envKey = "SAM_CLI_TELEMETRY";
	envVal = "0";
} opts
