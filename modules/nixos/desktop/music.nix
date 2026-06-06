{
  flake.modules.nixos.music = {
    inputs,
    pkgs,
    config,
    lib,
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
      sfizz-ui
      fluidsynth
      linuxsampler
      qsampler
      (pkgs.polyphone.overrideAttrs (_: {
        version = "2.6.0";

        src = pkgs.fetchFromGitHub {
          owner = "davy7125";
          repo = "polyphone";
          rev = "2.6.0";
          hash = "sha256-JOSc1LWW7YWENDcssX9+faWwXZIlIacAiyZNzVOaTHY=";
        };
      }))

      # Music Theory
      coltrane
    ];
  };
}
