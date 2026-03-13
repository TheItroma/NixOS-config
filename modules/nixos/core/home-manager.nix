{
  flake.modules.nixos.home-manager = { config, primaryUser, inputs, ... }: {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${primaryUser}.imports = [
        {
          home.homeDirectory = config.users.users.${primaryUser}.home;
        }
      ];
    };

	#    specialArgs = {
	#      inherit primaryUser inputs;
	#      configName = "${primaryUser}";
	#      nhSwitchCommand = "nh os switch";
	#    };
  };
}
