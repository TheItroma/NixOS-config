{ config, ... }: {
  nixosHosts.omegaBagel = {
    modules = [
      ./_nixos
    ]
    ++ (with config.flake.modules.nixos; [
      desktop
      gaming
      music
      vr
      nvidia
    ]);

    homeManagerModules = with config.flake.modules.homeManager; [
      core
      desktop
    ];
  };
}
