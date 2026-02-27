{
  flake.modules.nixos.mullvad = 
    { pkgs, ... }: {
      services.mullvad-vpn.enable = true;
    };
}
