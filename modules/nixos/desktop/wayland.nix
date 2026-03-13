{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      alacritty
      hyprsunset
      hyprpicker
      hyprshot
    ];

    #security.polkit.enable = true
	#   services.displayManager.ly = {
	#     enable = true;
	#     x11Support = false;
	#     settings = {
	#       animation = "colormix";
	#       clear_password = true;
	#       full_color = true;
	#       save = true;
	#       text_in_center = false;
	#     };
	#   };

    programs.niri.enable = true;

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
	    #withUWSM = true;
    };

    programs.uwsm = {
      enable = true;
      waylandCompositors.niri = {
        prettyName = "niri";
        comment = "Niri fork for blur";
        binPath = "/run/current-system/bin/niri";
      };
    };
 
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
