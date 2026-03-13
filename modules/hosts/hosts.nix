{ inputs, lib, config, ... }:

let
  inherit (lib) types mkOption mapAttrs;

  baseHostModule = { config, name, ... }: {
    options = {
      system = mkOption {type = types.str; default = "x86_64-linux"; };
      modules = mkOption { type = with types; listOf deferredModule; default = [ ]; };
      primaryUser = mkOption { type = types.str; default = "itroma"; };
      specialArgs = mkOption { type = types.attrsOf types.anything; default = { }; };
      nixpkgs = mkOption { type = types.pathInStore; };
      pkgs = mkOption { type = types.pkgs; };
    };

    config = {
      nixpkgs = inputs.nixpkgs;
      pkgs = import config.nixpkgs { inherit (config) system; config.allowUnfree = true; };
      specialArgs = { inherit inputs; inherit (config) primaryUser; };
    };
  };

  homeManagerModule = { config, primaryUser, name, ... }: {
    options = {
      specialArgs = mkOption {
        type = with types; attrsOf anything;
        default = { };
      };

      homeManagerModules = mkOption {
        type = with types; listOf deferredModule;
        default = [ ];
      };
    };

    config = {
      modules = [
        (
          { primaryUser, ... }:
          lib.optionalAttrs (config.homeManagerModules != [ ]) {
            home-manager.users.${primaryUser}.imports = config.homeManagerModules;
          }
        )
      ];

      specialArgs = {
        inherit primaryUser inputs;
        configName = "${primaryUser}";
        nhSwitchCommand = "nh os switch";
      };
    };
  };

  hostTypeNixos = types.submodule [

    baseHostModule
    homeManagerModule
    # The line above is simply allowing the top level host configuration to import modules.
    # Since we are using the NixOS home-manager module, the actual definition is in nixos/core.

    ({ name, ... }: {
      modules = [
        config.flake.modules.nixos.core
        { networking.hostName = name; }
      ];
    })
  ];
in {
  options = {
    nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
  };

  config.flake = {
    nixosConfigurations = let
      mkHost = hostname: options:
        options.nixpkgs.lib.nixosSystem {
          inherit (options) system modules specialArgs;
        };
    in mapAttrs mkHost config.nixosHosts;
  };
}
