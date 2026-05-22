{
  flake.modules.homeManager.hyprland = {
    pkgs,
    lib,
    ...
  }: let
    mkFiles = dir: files:
      builtins.listToAttrs (map (f: {
          name = "${dir}/${lib.baseNameOf f}";
          value.source = f;
        })
        files);
  in {
    home.file = mkFiles ".config/hypr" [
      ./animations.lua
      ./binds.lua
      ./monitor.lua
      ./settings.lua
    ];
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
      configType = "lua";
      extraConfig = ''
        require("animations")
        require("monitor")
        require("binds")
        require("settings")
      '';
    };
  };
}
