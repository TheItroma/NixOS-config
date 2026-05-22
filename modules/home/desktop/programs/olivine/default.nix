{
  flake.modules.homeManager.olivine = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      (pkgs.callPackage ./package.nix {})
    ];
  };
}
