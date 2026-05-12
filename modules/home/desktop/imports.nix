{
  config,
  inputs,
  pkgs,
  ...
}: {
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    inputs.nvf.homeManagerModules.nvf
    inputs.stylix.homeModules.stylix
    inputs.mango.hmModules.mango
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    librewolf
    easyeffects
    flatpak
    hyprland
    kitty
    niri
    mango
    theming
    desktop-programs
    wallpaper
    nixcord
    neovim
  ];
}
