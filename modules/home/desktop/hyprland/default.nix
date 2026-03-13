{
  flake.modules.homeManager.hyprland = {
    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  };
}
