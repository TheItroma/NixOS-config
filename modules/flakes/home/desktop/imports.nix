{ config, ... }: {
  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    hyprland
    desktop-programs
  ];
}
