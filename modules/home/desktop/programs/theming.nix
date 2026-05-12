{
  flake.modules.homeManager.theming = {
    primaryUser,
    pkgs,
    ...
  }: {
    stylix = {
      enable = true;
      image = /home/itroma/Pictures/image.jpg;
      polarity = "dark";

      targets.librewolf.profileNames = ["default"];
    };
  };
}
