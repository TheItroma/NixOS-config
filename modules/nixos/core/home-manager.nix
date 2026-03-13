{
  flake.modules.nixos.home-manager = { config, primaryUser, inputs, ... }: {
    home-manager = {
      userGlobalPkgs = true;
      useUserPackages = true;

      users.${primaryUser}.imports = [
        config.flake.modules.homeManager.core
        {
          home.homeDirectory = config.users.users.${primaryUser}.home;
        }
      ];
    };
  };
}
