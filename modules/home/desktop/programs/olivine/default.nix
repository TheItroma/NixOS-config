{
  flake.modules.homeManager.olivine = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = [
      (pkgs.callPackage ./_package.nix {
        customRC = ./rc.lua;
      })
    ];
  };
}
