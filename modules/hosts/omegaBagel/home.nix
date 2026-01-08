{ config, ... }: {
  flake.modules.homeManager.omegaBagel =
    {lib, ... }: {
      imports = with config.flake.modules.homeManager; [
        desktop
      ];
    };
}
