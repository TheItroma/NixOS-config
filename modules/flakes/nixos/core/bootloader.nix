{
  flake.modules.nixos.bootloader = { lib, ... }: {
    boot.loader = {
      timeout = 2;

      systemd-boot = {
        enable = true;
      };
    };
  };
}
