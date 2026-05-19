{
  flake.modules.nixos.man = {pkgs, ...}: {
    documentation.man.cache.enable = false;

    environment.systemPackages = with pkgs; [
      linux-manual
      man-pages
      man-pages-posix
    ];
  };
}
