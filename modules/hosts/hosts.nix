{ inputs, lib, config, ... }:

let
  inherit (lib) types mkOption mapAttrs;

  # Base host template
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

  hostTypeNixos = types.submodule [

    baseHostModule

    # Home Manager submodule
    ({ name, config, inputs, ... }: {

      options.homeManagerModules = mkOption {
        type = with types; listOf lib.deferredModule;
        default = [ ];
      };

      config.modules = [
        inputs.home-manager.nixosModules.home-manager

        ({ config, primaryUser, inputs, ... }: {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.${primaryUser}.imports = [
              config.homeManagerModules
              inputs.home-manager.modules.homeManager.core
            ];

            extraSpecialArgs = {
              inherit inputs;
              inherit primaryUser;
              configName = "nixos_${config.networking.hostName}";
              nhSwitchCommand = "nh os switch";
            };
          };
        })
      ];
    })

    # Host-specific NixOS modules
    ({ name, config, inputs, ... }: {
      modules = [
        inputs.nixos-modules.nixos.core
        { networking.hostName = name; }
        (inputs.nixos-modules.nixos."host_${name}" or { })
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
