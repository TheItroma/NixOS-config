{
  flake.modules.homeManager.wallpaper = {pkgs, ...}: {
    services.awww.enable = true;

    home.packages = with pkgs; [
      waypaper
    ];

    xdg.configFile."waypaper/config.ini".source = ./config.ini;
  };
}
