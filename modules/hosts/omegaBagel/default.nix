{config, ...}: {
  nixosHosts.omegaBagel = {
    modules =
      [
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
      dev
    ];

    #monitors = [
    #  {
    #    name = "HKC OVERSEAS LIMITED 27E6QC";
    #    location = "DP-2";
    #    width = 2560;
    #    height = 1440;
    #    refreshRate = "165.001";
    #    isMain = true;
    #  }
    #];
  };
}
