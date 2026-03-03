{ config, ... }: {
  homeHosts.home_poppySeed = {
    modules = [ ]
    ++ (with config.flake.modules.homeManager; [
      desktop
    ]);
  };
}
