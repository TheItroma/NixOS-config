{
  flake.modules.nixos.home-manager =
    { config, primaryUser, ... }:
    let
      inherit (config.networking) hostName;
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
  
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
  
        users.${primaryUser}.imports = [
          config.flake.modules.homeManager.core
          {
            # Ensure that the NixOS's HOMEDIR for this user is the same as home-manager's
            home.homeDirectory = config.users.users.${primaryUser}.home;
  
          }
        ];
  
        extraSpecialArgs = {
          inherit inputs;
          inherit primaryUser;
          configName = "nixos_${hostName}";
          nhSwitchCommand = "nh os switch";
        };
      };
    };
}
