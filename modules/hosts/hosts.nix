{ inputs, lib, config, ... }:

let
  inherit (lib) types mkOption mapAttrs;

  baseHostModule = { config, name, ... }: {
    options = {
      system = mkOption { type = types.str; default = "x86_64-linux"; };
      modules = mkOption { type = with types; listOf deferredModule; default = [ ]; };
      primaryUser = mkOption { type = types.str; default = "itroma"; };
      specialArgs = mkOption { type = types.attrsOf types.anything; default = { }; };
      nixpkgs = mkOption { type = types.pathInStore; };
      pkgs = mkOption { type = types.pkgs; };
    };

    config = {
      nixpkgs = inputs.nixpkgs;
      pkgs = import config.nixpkgs {
        inherit (config) system;
        config.allowUnfree = true;
      };
      specialArgs = { inherit inputs; inherit (config) primaryUser; };
    };
  };

  hostTypeNixos = types.submodule [

    baseHostModule

    # Home Manager modules
    ({ name, config, inputs, ... }: {

      options.homeManagerModules = mkOption {
        type = with types; listOf lib.deferredModule;
        default = [ ];
      };

      config.modules = [

        ({ primaryUser, ... }: {
          home-manager.users.${primaryUser}.imports = config.homeManagerModules;
        })

        ({ config, primaryUser, inputs, ... }: {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            # Reference Home Manager core via inputs instead of self
            users.${primaryUser}.imports = [
              inputs.flake-modules.homeManager.core
              { home.homeDirectory = config.users.users.${primaryUser}.home; }
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
    ({ name, ... }: {
      modules = [
        inputs.flake-modules.nixos.core
        { networking.hostName = name; }
        (inputs.flake-modules.nixos."host_${name}" or { })
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
