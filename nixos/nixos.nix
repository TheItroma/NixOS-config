{ inputs, ... }: {
  flake = {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
        ];
      };
    };
  };
}
