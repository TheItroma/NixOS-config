{
  config,
  inputs,
  pkgs,
  ...
}: {
  flake.modules.nixos.copyparty.imports = with config.flake.modules.nixos; [
    inputs.copyparty.nixosModules.default
  ];
}
