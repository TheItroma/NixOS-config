{
  flake.modules.homeManager.dwl = {
    config,
    lib,
    pkgs,
    ...
  }: {
    import = [./_dwl/flake.nix];
    home.packages = with pkgs; [
      foot
    ];
    # Features I want :
    #  Right side scratch pad just like niri but for a music player
    #  Eye candy
    #  Tile layout with rotation
    #  Window n limiter
    wayland.windowManager.dwl = {
      enabled = true;
      settings = {
        monitors = [
          {
            name = "DP-2";
            mfact = 1.0;
            nmaster = 1;
            scale = 1.5;
          }
        ];
      };
      patcheDir = "./patches";
    };
  };
}
