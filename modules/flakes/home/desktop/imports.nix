{ config, pkgs, ... }: {
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    librewolf
    hyprland
    kitty
    niri
    desktop-programs
    wallpaper
    nixcord
    dwl
  ];
}
