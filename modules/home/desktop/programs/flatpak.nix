{
  flake.modules.homeManager.flatpak = {pkgs, ...}: {
    services.flatpak = {
      enable = true;
      packages = [
        "org.vinegarhq.Sober"
      ];
    };
    home.packages = with pkgs; [
      flatpak
    ];
  };
}
