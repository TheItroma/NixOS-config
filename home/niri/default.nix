{ pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    hyprpolkitagent # Just a polkit brah
    xdg-desktop-portal-gtk # Basic functionality
    xdg-desktop-portal-gnome # Screencast support
    xwayland-satellite # Xwayland support
  ];
}
