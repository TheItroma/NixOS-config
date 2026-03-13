{ inputs, pkgs, ... }: {
  flake.modules.nixos.music = {
    imports = [ inputs.musnix.nixosModules.musnix ];
    #musnix = {
      #enable = true;
      #rtcqs.enable = true;
      #kernel.realtime = true;
    #};

    environment.systemPackages = with pkgs; [
      # Music making
      	#reaper
      ardour
      sfizz
    ];
  };
}
