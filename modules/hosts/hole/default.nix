{config, ...}: {
  nixosHosts.hole = {
    modules =
      [
        ./_nixos
      ]
      ++ (with config.flake.modules.nixos; [
        desktop
      ]);

    homeManagerModules = with config.flake.modules.homeManager; [
      core
      desktop
      dev
    ];
  };
}
