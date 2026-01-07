{
  flake.modules.nixos.nix = {
    nixpkgs.config = {
      allowUnfree = true;
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "05:00";
        extraArgs = "--keep 5 --keep-since 8d";
      };
    };

    nix = {
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
        max-jobs = "auto";
        #min-free = 128000000; # 128 MB
        #max-free = 1000000000; # 1 GB
        auto-optimise-store = true;
        warn-dirty = false;
        connect-timeout = 5;
        trusted-users = [
          "root"
          "@wheel"
        ];
        fallback = true;
      };
    };
  };
}
