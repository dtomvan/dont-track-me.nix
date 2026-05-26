{
  name,
  envKey ? null,
  envVal ? "1",
  extraConfig ? { },
}:
{ lib, config, ... }:
let
  cfg = config.dont-track-me;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.dont-track-me.trackers.${name}.enable = mkEnableOption "blocking tracking from ${name}";
  config = mkIf (cfg.enableAll || cfg.trackers.${name}.enable) (
    {
      home.sessionVariables = mkIf (envKey != null) {
        "${envKey}" = envVal;
      };
    }
    // extraConfig
  );
}
