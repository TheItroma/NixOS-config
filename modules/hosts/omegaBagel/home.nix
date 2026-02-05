{ config, ... }: {

#  flake.modules.homeManager.host_omegaBagel = {
#    imports = with config.flake.modules.homeManager; [
#      desktop
#    ];
  homeHosts.home_omegaBagel = {
    modules = [ ]
    ++ (with config.flake.modules.homeManager; [
      desktop
    ]);
  };
}
