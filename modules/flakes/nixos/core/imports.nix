{ config, inputs, ... }: {
  flake.modules.nixos.core.imports = with config.flake.modules.nixos; [
    bootloader
    users
    nix
  ];
}
