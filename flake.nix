{
  description = "I have no idea what the fuck im doing";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Flake parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.flake-parts.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:Naxdy/niri";
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
    home-manager,
    flake-parts,
    nixpkgs-xr,
    niri,
    ...
  } @ inputs:

    flake-parts.lib.mkFlake { inherit inputs; }
    {
      imports = [
        ./nixos/nixos.nix
      ];
    };
}
