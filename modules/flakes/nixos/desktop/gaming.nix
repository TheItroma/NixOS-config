{
  flake.modules.nixos.gaming
    { pkgs, ... }: {
      hardware.xone.enable = true;

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };

      environment.systemPackages = with pkgs; [
        # Gaming
        gamemode # Better performances or whatever
        # proton-ge-rtsp-bin # It was in the nixpkgs-xr overlay sooo
        protonup-qt # Just a gui for other proton installs
        umu-launcher # Proton using non-steam games https://lvra.gitlab.io/docs/games/vr-no-steam/
      ];
    };
}
