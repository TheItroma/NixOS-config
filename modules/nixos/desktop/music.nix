{
  flake.modules.nixos.music = {
    inputs,
    pkgs,
    config,
    ...
  }: {
    imports = [inputs.musnix.nixosModules.musnix];

    musnix = {
      enable = true;
      rtcqs.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Daw
      reaper
      zrythm
      ardour
      qtractor

      # Synth
      surge-xt
      zynaddsubfx
      yoshimi

      # FX
      calf
      eq10q
      infamousPlugins
      wolf-shaper
      lsp-plugins

      # Samplers
      sfizz
    ];
  };
}
