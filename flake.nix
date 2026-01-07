{
  description = "I am starting to have an idea of what im doing";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Flake parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.flake-parts.follows = "nixpkgs";
    };

    # Flake files
    flake-file = {
      url = "github:vic/flake-file";
      inputs.flake-file.follows = "flake-parts";
    };

    # Import tree
    import-tree = {
      url = "github:vic/flake-file";
      inputs.import-tree.follows = "flake-parts";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:Naxdy/niri";

    # Nixpkgs vr override for the devs versions
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

  };
}
