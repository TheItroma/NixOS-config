{ inputs, ... }: {
  flake = {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.itroma = import ./home/home.nix;
          }
          nixpkgs-xr.nixosModules.nixpkgs-xr
        ];
      };
    };
  };
};
