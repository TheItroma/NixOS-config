{
  description = "I have no idea what the fuck im doing";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland stuff
	#    hyprland.url = "github:hyprvm/Hyprland";
	#
	#    hyprfocus = {
	#      url = "github:pyt0xic/hyprfocus";
	#      inputs.hyprland.follows = "hyprland";
	#    };
	#
	#    hyprNStack = {
	#      url = "github:zakk4223/hyprNStack";
	#      inputs.hyprland.follows = "hyprland";
	#    };
	#
	#    hyprshade = {
	#      url = "github:loqusion/hyprshade";
	#      inputs.hyprland.follows = "hyprland";
	#    };
	#
	#    hyprRiver = {
	#      url = "github:zakk4223/hyprRiver";
	#      inputs.hyprland.follows = "hyprland";
	#    };
	#
	#    hypr-dynamic-cursors = {
	#      url = "github:VirtCode/hypr-dynamic-cursors";
	#      inputs.hyprland.follows = "hyprland";
	#    };
	#
    # Nixpkgs vr override for the devs versions
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-xr,
    home-manager,
	...
	} @ inputs:

  let
    system = "x86_64-linux";
  in

  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
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
}
