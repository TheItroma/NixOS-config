{
  config,
  pkgs,
  inputs,
  ...
}: {
  flake.modules.nixos.copyparty = {
    nixpkgs.overlays = [inputs.copyparty.overlays.default];
    services.copyparty = {
      enable = true;
      group = "copyparty";
      settings = {
      };
      accounts = {
      };
    };
  };
}
