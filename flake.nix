{
  inputs = {};
  outputs = {...}: {
    homeManagerModules.default = {
      config,
      pkgs,
      lib,
      ...
    }: let
      cfg = config.dont-track-me;
    in {
      imports = [
        ./trackers/awssam.nix
        ./trackers/azure.nix
        ./trackers/brew.nix
        ./trackers/dotnet.nix
        ./trackers/flox.nix
        ./trackers/gatsby.nix
        ./trackers/netlify.nix
        ./trackers/syncthing.nix
      ];
      options.dont-track-me = with lib; {
        enable =
          mkEnableOption ''            Start blocking trackers in home. 
            For this to work it is required that you manage your login shell through home-manager'';
        enableAll = mkEnableOption "Block all trackers that are known in the module";
      };
      config = lib.mkIf cfg.enable {
        home.sessionVariables = {
          DO_NOT_TRACK = "1";
        };
      };
    };
  };
}
