{ config, primaryUser, inputs, ... }: {
  flake.modules.nixos.home-manager = {
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
    extraSpecialArgs = {
      inherit primaryUser inputs;
      configName = "${primaryUser}";
      nhSwitchCommand = "nh os switch";
    };
  };
}
