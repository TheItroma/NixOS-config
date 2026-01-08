{
  flake.modules.nixos.users = {
    users.users.itroma = {
      isNormalUser = true;
      extraGroups = [ "wheel" "input" "networkmanager" ];
    };
  };
}
