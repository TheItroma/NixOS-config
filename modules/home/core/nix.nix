{
  flake.modules.homeManager.nix = {
    nixpkgs.config.allowUnfree = true;
    nix.settings = {
      warn-dirty = false;
      experimental-features = "nix-command flakes";

      #use-xdg-base-directories = true;
    };
  };
}
