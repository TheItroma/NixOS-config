{
  flake.modules.homeManager.theming = { primaryUser, pkgs, ... }: {

    stylix = {

      enable = true;
      image = /home/itroma/Downloads/image.jpg;
      polarity = "dark";

      targets.librewolf.profileNames = [ "default" ];
    };
  };
}
