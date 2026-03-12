{ inputs, lib, config, self, ... }:

let
  inherit (lib) types mkOption mapAttrs elemAt optionalAttrs;
  inherit (builtins) null;

in {
  options =
    let
      baseHostModule = { config, name, ... }: {
        options = {
          system = mkOption {
            type = types.str;
            default = "x86_64-linux";
          };
          modules = mkOption {
            type = with types; listOf deferredModule;
            default = [ ];
          };
          primaryUser = mkOption {
            type = types.str;
            default = "itroma";
          };
          specialArgs = mkOption {
            type = with types; attrsOf anything;
            default = { };
          };
          nixpkgs = mkOption {
            type = types.pathInStore;
          };
          pkgs = mkOption {
            type = types.pkgs;
          };
        };
        config = {
          nixpkgs = inputs.nixpkgs;
          pkgs = import config.nixpkgs {
            inherit (config) system;
            config.allowUnfree = true;
          };
          specialArgs = {
            inherit inputs;
            inherit (config) primaryUser;
          };
        };
      };

      hostTypeNixos = types.submodule [
        baseHostModule
<<<<<<< HEAD
        ({ name, config, inputs, ... }: {
          options.homeManagerModules = lib.mkOption {
            type = with lib.types; listOf deferredModule;
            default = [ ];
          };
          config.modules = [
            ({ primaryUser, ... }: {
              home-manager.users.${primaryUser}.imports =
                config.homeManagerModules;
            })
            ({ config, primaryUser, inputs, self, ... }: 
              let
                # Use self instead of config.flake
                homeManagerCore = self.modules.homeManager.core;
              in {
                imports = [ inputs.home-manager.nixosModules.home-manager ];
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;

                  users.${primaryUser}.imports = [
                    homeManagerCore
                    {
                      home.homeDirectory = config.users.users.${primaryUser}.home;
                    }
                  ];
=======
        (
          {name, config, inputs, ... }: {
            options.homeManagerModules = lib.mkOption {
              type = with lib.types; listOf deferredModule;
              default = [ ];
            };
            config.modules = [
              (
                { primaryUser, ... }: {
                  home-manager.users.${primaryUser}.imports =
                    config.homeManagerModules;
                }
              )
              (
                { self, config, primaryUser, inputs, ... }: {
                  imports = [ inputs.home-manager.nixosModules.home-manager ];
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;

                    users.${primaryUser}.imports = [
                      self.modules.homeManager.core
                      {
                        home.homeDirectory = config.users.users.${primaryUser}.home;
                      }
                    ];
>>>>>>> 8d488be (ah)

                  extraSpecialArgs = {
                    inherit (self) inputs;
                    inherit primaryUser;
                    configName = "nixos_${config.networking.hostName}";
                    nhSwitchCommand = "nh os switch";
                  };
                };
              }
            )
          ];
        })
        ({ name, ... }: {
          modules = [
            config.flake.modules.nixos.core
            { networking.hostName = name; }
            (config.flake.modules.nixos."host_${name}" or { })
          ];
        })
      ];

    in {
      nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
    };

  config.flake = {

    nixosConfigurations =
      let
        mkHost = hostname: options:
          options.nixpkgs.lib.nixosSystem {
            inherit (options) system modules specialArgs;
          };
      in mapAttrs mkHost config.nixosHosts;
  };
}
