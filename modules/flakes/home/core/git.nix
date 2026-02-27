{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "TheItroma";
          email = "edmondliseuse@gmail.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
