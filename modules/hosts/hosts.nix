{
  inputs,
  lib,
  config,
  self,
  ...
}@flakeArgs: let inherit (lib) types mkOption; in {
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
        };
      };

      hostTypeNixos = types.submodule [
        baseHostModule
        (
	  { name, ... }: {
            modules = [
              config.flake.modules.nixos.core
              { networking.hostName = name; }
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
            ];
          }
	)
      ];

    in {
      # An AttrSet of AttrSet, idk why this took so long for me to ingest
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
            specialArgs.inputs = inputs;
            inherit (options) system modules;
          };
      # While also allowing the simple declaration of hosts
      in lib.mapAttrs mkHost config.nixosHosts;
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
      lib.mapAttrs mkHost config.homeHosts;
  };
}
