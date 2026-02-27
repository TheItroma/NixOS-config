{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      enable = true;

      settings.PasswordAuthentication = false;
    };
    users.users = 
      let
        persoKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOg6wRaFYg2WxoR+AocZAu1jvugCo03abxPiCneA3Gie";
      in
      {
        root.openssh.authorizedKeys.keys = [ persoKey ];
      };
  };
}
