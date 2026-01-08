{
  flake.modules.nixos.sound =
    { pkgs, ... }: {

      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa.enable = true;
        jack.enable = true;
      };

      environement.systemPackages = with pkgs; [
        # Audio
        alsa-utils
        pavucontrol
        qpwgraph
        qjackctl
      ];
    };
}
