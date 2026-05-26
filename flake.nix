{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      perSystem =
        f:
        lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ] (
          system:
          f {
            inherit lib system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      checks = perSystem (
        { pkgs, ... }:
        {
          default =
            (home-manager.lib.homeManagerConfiguration {
              inherit pkgs;
              modules = [
                self.homeManagerModules.default
                (
                  { config, ... }:
                  let
                    inherit (config.home) sessionVariables shellAliases;
                  in
                  {
                    assertions = [
                      { assertion = sessionVariables.AZURE_CORE_COLLECT_TELEMETRY == "0"; }
                      { assertion = sessionVariables.HOMEBREW_NO_ANALYTICS == "1"; }
                      { assertion = sessionVariables.FLOX_DISABLE_METRICS == "true"; }
                      { assertion = sessionVariables.DOTNET_CLI_TELEMETRY_OPTOUT == "1"; }
                      { assertion = sessionVariables.GATSBY_TELEMETRY_DISABLED == "1"; }
                      { assertion = sessionVariables.SAM_CLI_TELEMETRY == "0"; }
                      { assertion = shellAliases.netlify == "netlify --telemetry-disable"; }
                      { assertion = sessionVariables.STNOUPGRADE == "1"; }
                    ];

                    dont-track-me = {
                      enable = true;
                      enableAll = true;
                    };
                    home = {
                      stateVersion = "26.05";
                      username = "nixos";
                      homeDirectory = "/home/nixos";
                    };
                  }
                )
              ];
            }).config.home.activationPackage;
        }
      );

      formatter = perSystem ({ pkgs, ... }: pkgs.nixfmt-tree);
      homeManagerModules.default =
        { config, lib, ... }:
        let
          cfg = config.dont-track-me;
          inherit (lib) mkEnableOption mkIf;
        in
        {
          imports = lib.pipe ./trackers [
            builtins.readDir
            (lib.filterAttrs (n: ty: ty == "regular" && lib.hasSuffix ".nix" n))
            builtins.attrNames
            (map (p: import ./lib/mk-tracker-blocker.nix (import ./trackers/${p})))
          ];
          options.dont-track-me = {
            enable = mkEnableOption "blocking trackers";
            enableAll = mkEnableOption "all trackers without enabling them one-by-one manually";
          };
          config.home.sessionVariables.DO_NOT_TRACK = mkIf cfg.enable "1";
        };
    };
}
