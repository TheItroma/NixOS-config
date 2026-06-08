{inputs, ...}: {
  flake.modules.nixos.nur = {
    nixpkgs.overlays = [inputs.nur.overlays.default];
  };
}
