{
  flake.modules.nixos.music = { inputs, pkgs, ... }: {

    imports = [ inputs.musnix.nixosModules.musnix ];

    musnix = {
      enable = false;
      rtcqs.enable = true;
    };

    environment.systemPackages = with pkgs; [
      # Daw
      reaper
      ardour

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
