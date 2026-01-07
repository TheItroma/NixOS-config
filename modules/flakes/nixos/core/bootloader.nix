{
  flake.modules.nixos.bootloader = { lib, ... }: {
    boot.loader = {
      timeout = lib.mkDefault 2;

      systemd-boot = {
        enable = true;
      };
    };
  };
}
