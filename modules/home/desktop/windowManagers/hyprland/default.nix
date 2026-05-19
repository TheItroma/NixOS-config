{
  flake.modules.homeManager.hyprland = {
    pkgs,
    lib,
    ...
  }: {
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
    };
    home.file = let
      lua = [
        ./hyprland.lua
        ./animations.lua
        ./binds.lua
        ./monitor.lua
      ];
    in
      builtins.listToAttrs (
        map (e: {
          name = ".config/hypr/${lib.baseNameOf e}";
          value = {
            source = e;
          };
        })
        lua
      );
  };
}
