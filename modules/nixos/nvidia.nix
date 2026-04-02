{
  flake.modules.nixos.nvidia = { pkgs, config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };

      nvidia = {
        modesetting.enable = true;
        powerManagement = {
          enable = false;
          finegrained = false;
        };
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
      };
    };
    # Fixes tauri issues
    environment.sessionVariables = { __NV_DISABLE_EXPLICIT_SYNC = "1"; };
  };
}
