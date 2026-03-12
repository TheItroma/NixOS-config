{ inputs, lib, config, self, ... }@flakeArgs:

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

    # Home Manager + host-specific configuration
    ({ name, config, inputs, self, ... }: {

      options.homeManagerModules = mkOption {
        type = with types; listOf lib.deferredModule;
        default = [ ];
      };

      config.modules = [

        # Apply host-specific Home Manager modules
        ({ primaryUser, ... }: {
          home-manager.users.${primaryUser}.imports = config.homeManagerModules;
        })

        # Home Manager core + extra special args
        ({ config, primaryUser, inputs, self, ... }: {
          imports = [ inputs.home-manager.nixosModules.home-manager ];
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users.${primaryUser}.imports = [
              self.modules.homeManager.core
              { home.homeDirectory = config.users.users.${primaryUser}.home; }
            ];

            extraSpecialArgs = {
              inherit (self) inputs;
              inherit primaryUser;
              configName = "nixos_${config.networking.hostName}";
              nhSwitchCommand = "nh os switch";
            };
          };
        })
      ];
    })

    # Host-specific NixOS modules
    ({ name, self, ... }: {
      modules = [
        self.modules.nixos.core
        { networking.hostName = name; }
        (self.modules.nixos."host_${name}" or { })
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
