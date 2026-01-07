{
  flake.modules.nixos.nvidia = { pkgs, config, ... }: {
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
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
    # Fixes tauri issues
    environment.sessionVariables = { __NV_DISABLE_EXPLICIT_SYNC = "1"; };
  };
}
