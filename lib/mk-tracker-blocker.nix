{
	name,
	envKey ? false,
	envVal ? "1",
	extraConfig ? {},
}: { lib, config, ... }: let
	cfg = config.dont-track-me;
in {
	options.dont-track-me.trackers."${name}".enable = lib.mkEnableOption "block tracking from ${name}";
	config = lib.mkIf (cfg.enableAll || cfg.trackers."${name}".enable) ({
		home.sessionVariables = lib.mkIf (envKey != false) {
			"${envKey}" = envVal;
		};
	} // extraConfig);
}
