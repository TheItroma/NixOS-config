{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    systemd.enable = false;
    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  }
}
