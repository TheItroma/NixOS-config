{
  flake.modules.nixos.man = {pkgs, ...}: {
    documentation.man.generateCaches = true;

    environment.systemPackages = with pkgs; [
      linux-manual
      man-pages
      man-pages-posix
    ];
  };
}
