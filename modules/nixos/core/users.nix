{
  flake.modules.nixos.users = { primaryUser, ... }: {
    users = {
	    #      root = {
	    #        isSystemUser = true;
	    #      };

      ${primaryUser} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "input" "networkmanager" ];
      };
    };
  };
}
