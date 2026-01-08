{ config, inputs, ... }:
{
  flake.modules.nixos.desktop.imports = with config.flake.modules.nixos; [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
    inputs.musnix.nixosModules.musnix

    gaming
    sound
    vr
    music
    bluetooth
  ];
}
