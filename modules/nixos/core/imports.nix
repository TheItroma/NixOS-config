{
  config,
  inputs,
  ...
}: {
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko

    sops
    man
    ssh-server
    bootloader
    users
    nix
    home-manager
  ];
}
