{
  flake.modules.homeManager.home-manager = {
    # Should I throw this
    home.stateVersion = "25.05";
    programs.home-manager.enable = true;
  };
}
