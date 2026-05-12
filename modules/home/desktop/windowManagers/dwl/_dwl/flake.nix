{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      flake = {
        homeModule.dwl = import ./nix/homeManager/default.nix;
      };
      perSystem = {
        config,
        pkgs,
        ...
      }: let
        dwl = pkgs.callPackage ./nix/homeManager/package.nix;
      in {
        packages.default = dwl;
        overlayAttrs = {
          inherit (config.packages) dwl;
        };
        packages = {
          inherit dwl;
        };
        systems = [
          "x86_64-linux"
        ];
      };
    };
}
