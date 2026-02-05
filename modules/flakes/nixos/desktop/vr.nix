{
  flake.modules.nixos.vr =
    { pkgs, ... }: {
      services.wivrn = {
        enable = true;
        openFirewall = true;
        autoStart = true;
        package = (pkgs.wivrn.override { cudaSupport = true; });
      };
      
      environment.systemPackages = with pkgs; [
        slimevr # Trackers
        wayvr # Vr application launcher (replaces steamvr)
        vrc-get # Cli tool to inject vrc packages to unity
        alcom # UI for vrc-get
        xrizer # OpenVR -> OpenXR
        # xrbinder # To bind stuff
      ];
    };
}
