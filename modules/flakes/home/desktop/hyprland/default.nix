{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };
      xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    };
}
