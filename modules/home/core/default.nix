{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      primaryUser,
      ...
    }: {
      home = {
        username = primaryUser;
		#homeDirectory = "/home/${config.home.username}";
      };
    };
}
