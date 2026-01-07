{ config, ... }: {
  nixosHosts.omegaBagel = {

    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
      nvidia
    ]);
  };
}
