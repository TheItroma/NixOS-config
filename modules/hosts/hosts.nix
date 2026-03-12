{
  inputs,
  lib,
  config,
  self,
  ...
}@flakeArgs: let
  inherit (lib) types mkOption mapAttrs elemAt optionalAttrs;
  inherit (builtins) null;
in {
  options =
    let
      baseHostModule = { config, name, ... }: {
        let

          options = {
            system = [ str "x86_64-linux" ];
            modules = [ (listOf deferredModule) [ ] ];
            nixpkgs = [ pathInStore, null ];
            pkgs = [ pkgs, null ];
            primaryUser = [ str "itroma" ];
            specialArgs = [ (attrsOf anything) {} ];
          };

          mkOptions =
            name: options:
            name = mkOption {
              type = with types; elemAt options 0;
              default = options;
            };
        in
        mapAttrs mkOptions options;

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
	(
	  {name, config, ... }: {
            options.homeManagerModules = lib.mkOption {
              type = with lib.types; listOf deferredModule;
              default = [ ];
            };
            config.modules = [
              (
                { primaryUser, ... }: {
                  inputs.home-manager.users.${primaryUser}.imports =
                    config.homeManagerModules;
                }
              )
            ];
          }
        )
        (
	  { name, ... }: {
            modules = [
              config.flake.modules.nixos.core
              { networking.hostName = name; }
	      (config.flake.modules.nixos."host_${name}" or { })
            ];
          }
	)
      ];

      hostTypeHomeManager = types.submodule [
        baseHostModule
        (
	  { name, ... }: {
            modules = [
              config.flake.modules.homeManager.core
	      (
	        { pkgs, ... }: {
		  nix.package = pkgs.nix;
		}
	      )
            ];
          }
	)
      ];

    in {
      # An AttrSet of AttrSet, idk why this took so long for me to ingest
      # It obviously allows to have multiple modules... Which is what the "Hosts" are
      nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
      homeHosts = mkOption { type = types.attrsOf hostTypeHomeManager; };
    };

  config.flake = {

    nixosConfigurations = 
      let
        # This took a bit for me to get it. Bassically, it defines a function under here
        mkHost = 
          # This functions simply makes the basic options available to the whole config
          hostname: options:
          # Makes the evaluation pure https://nixos.wiki/wiki/Flakes
          options.nixpkgs.lib.nixosSystem {
            inherit (options) system modules specialArgs;
          };
      # While also allowing the simple declaration of hosts
      in mapAttrs mkHost config.nixosHosts;
      # lib.mapAttrs [arg1 = function, arg2 = attrSet to itterate through]

    homeConfigurations =
      let
        mkHost =
          configName: options:
          inputs.home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {
              inputs = inputs;
              inherit configName;
              nhSwitchCommand = "nh home switch --configuration ${configName}";
            };
            inherit (options) pkgs modules;
          };
      in
      mapAttrs mkHost config.homeHosts;
  };
}
