{
  flake.modules.homeManager.desktop = {
    programs.bash = {
      enable = true;
      shellAliases = {
        up = "home-manager switch --flake /home/itroma/NixOS-config#home_omegaBagel"; # Change this
      };
    };
  };
}
