{ config, inputs, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    sound
    bluetooth
    mullvad
  ];
}
