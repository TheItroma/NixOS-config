{ config, lib, pkgs, ... }:

{
  niri.nixosModules.default = {
    programs.niri.enable = true;
    programs.uwsm = {
      enable = true;
      waylandCompositors.niri = {
        prettyName = "niri";
        comment = "Niri fork for blur";
        binPath = "/run/current-system/bin/niri";
      };
    };
  };
  
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    hyprpolkitagent # Just a polkit brah
    xdg-desktop-portal-gtk # Basic functionality
    xdg-desktop-portal-gnome # Screencast support
    xwayland-satellite # Xwayland support
  ];
}
