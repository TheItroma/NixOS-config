{
  flake.modules.homeManager.niri = { config, lib, pkgs, ... }: {

    home.packages = with pkgs; [
      hyprpolkitagent # Just a polkit brah
      xdg-desktop-portal-gtk # Basic functionality
      xdg-desktop-portal-gnome # Screencast support
      xwayland-satellite # Xwayland support
    ];


    services.polkit-gnome.enable = true;
    programs.waybar.enable = true;
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
