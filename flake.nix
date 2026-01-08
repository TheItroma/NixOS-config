{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Flake parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    # Flake files
    #flake-file = {
    #  url = "github:vic/flake-file";
    #  inputs.flake-file.follows = "flake-parts";
    #};

    # Import tree
    import-tree = {
      url = "github:vic/import-tree";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Niri, the WM
    niri.url = "github:Naxdy/niri";

    # Optimisations for real-time audio
    musnix = {
      url = "github:musnix/musnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixpkgs vr override for the devs versions
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";

  };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
