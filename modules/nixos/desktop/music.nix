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
      audacity
      ardour
      qtractor
      carla

      # Synth
      surge-xt
      helm
      vital
      zynaddsubfx
      yoshimi

      # FX
      calf
      eq10q
      distrho-ports
      infamousPlugins
      wolf-shaper
      lsp-plugins

      # Samplers
      sfizz
      fluidsynth
      linuxsampler
      qsampler
      polyphone

      # Music Theory
      coltrane
    ];
  };
}
