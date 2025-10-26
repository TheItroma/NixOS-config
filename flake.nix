{
  description = "Your new nix config";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: {

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        modules = [
	  ./nixos/configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.itroma = import ./home/home.nix;
	  }
	];
      };
    };
  };
}
