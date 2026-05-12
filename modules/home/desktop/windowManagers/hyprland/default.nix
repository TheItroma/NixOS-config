{
  flake.modules.homeManager.hyprland = {
    services = {
      hypridle = {
        enable = true;
      };

      hyprsunset = {
        enable = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = {
        "$mod" = "SUPER";

        bind = [
          #
        ];
      };
    };
  };
}
