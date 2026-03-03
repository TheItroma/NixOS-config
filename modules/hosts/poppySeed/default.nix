{ config, ... }: {
  nixosHosts.poppySeed = {
    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
    ]);
  };
}
