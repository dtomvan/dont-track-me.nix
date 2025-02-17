opts: import ../lib/mk-tracker-blocker.nix {
	name = "flox";
	envKey = "FLOX_DISABLE_METRICS";
	envVal = "true";
} opts
