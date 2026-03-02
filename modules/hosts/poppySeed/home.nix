{ config, ... }: {
  homeHosts.home_omegaBagel = {
    modules = [ ]
    ++ (with config.flake.modules.homeManager; [
      desktop
    ]);
  };
}
