opts: import ../lib/mk-tracker-blocker.nix {
	name = "dotnet";
	envKey = "DOTNET_CLI_TELEMETRY_OPTOUT";
} opts
