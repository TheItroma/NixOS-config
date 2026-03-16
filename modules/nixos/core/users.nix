{
  flake.modules.nixos.users = { primaryUser, ... }: {
    users.users = {
	    #      root = {
	    #        isSystemUser = true;
	    #      };

      ${primaryUser} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "input" "networkmanager" "audio" ];
      };
    };
  };
}
