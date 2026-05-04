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
    flatpak
    hyprland
    kitty
    niri
    mango
    desktop-programs
    wallpaper
    dwl
    nixcord
    neovim
  ];
}
