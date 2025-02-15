opts: import ../lib/mk-tracker-blocker.nix {
	name = "brew";
	envKey = "HOMEBREW_NO_ANALYTICS";
} opts
