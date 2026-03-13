{
  flake.modules.nixos.home-manager = { config, primaryUser, inputs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${primaryUser} = {
        home.stateVersion = "25.05";
        imports = [
          {
            home.homeDirectory = config.users.users.${primaryUser}.home;
          }
        ];
      };
    };

	#    specialArgs = {
	#      inherit primaryUser inputs;
	#      configName = "${primaryUser}";
	#      nhSwitchCommand = "nh os switch";
	#    };
  };
}
