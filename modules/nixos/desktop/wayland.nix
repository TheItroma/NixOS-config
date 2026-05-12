{
  flake.modules.nixos.desktop = {pkgs, ...}: {
    programs.niri.enable = true;

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
