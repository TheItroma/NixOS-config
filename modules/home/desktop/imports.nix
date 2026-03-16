{ config, inputs, pkgs, ... }: {
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [

    inputs.nvf.homeManagerModules.nvf
    inputs.stylix.homeModules.stylix

    librewolf
    hyprland
    kitty
    niri
    desktop-programs
    wallpaper
    dwl
    nixcord
    neovim
    theming
  ];
}
