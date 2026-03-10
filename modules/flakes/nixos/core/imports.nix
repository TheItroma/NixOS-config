{ config, inputs, ... }: {
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    inputs.disko.nixosModules.disko
    sops
    ssh-server
    bootloader
    users
    nix
    home-manager
  ];
}
