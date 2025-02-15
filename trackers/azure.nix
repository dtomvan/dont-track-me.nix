opts: import ../lib/mk-tracker-blocker.nix {
	name = "azure";
	envKey = "AZURE_CORE_COLLECT_TELEMETRY";
	envVal = "0";
} opts
