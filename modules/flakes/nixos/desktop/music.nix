{
  flake.modules.nixos.music =
    { pkgs, ... } : {
      musnix = {
        enable = true;
        rtcqs.enable = true;
        kernel.realtime = true;
      };

      environment.systemPackages = with pkgs; [
        # Music making
        reaper
        ardour
        sfizz
      ];
    };
}
