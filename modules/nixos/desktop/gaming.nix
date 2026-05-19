{
  flake.modules.nixos.gaming = {pkgs, ...}: {
    hardware.xone.enable = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      winetricks
      protontricks
      (pkgs.lutris-free.override {
        # Override the underlying lutris package
        lutris = pkgs.lutris.override {
          # Intercept buildFHSEnv to modify target packages
          buildFHSEnv = args:
            pkgs.buildFHSEnv (args
              // {
                multiPkgs = envPkgs: let
                  # Fetch original package list
                  originalPkgs = args.multiPkgs envPkgs;

                  # Disable tests for openldap
                  customLdap = envPkgs.openldap.overrideAttrs (_: {doCheck = false;});
                in
                  # Replace broken openldap with the custom one
                  builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [customLdap];
              });
        };
      })
      gamemode
      gamescope
      protonup-qt
      umu-launcher
      osu-lazer
      unciv
      deadlock-mod-manager
    ];
  };
}
