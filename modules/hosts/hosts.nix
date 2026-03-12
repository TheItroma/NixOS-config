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

    in {
      # An AttrSet of AttrSet, idk why this took so long for me to ingest
      # It obviously allows to have multiple modules... Which is what the "Hosts" are
      nixosHosts = mkOption { type = types.attrsOf hostTypeNixos; };
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
  };
}
