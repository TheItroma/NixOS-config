{
  flake.modules.homeManager.core =
    {
      lib,
      pkgs,
      config,
      ...
    }: {
      home = {
        username = lib.mkDefault "itroma";
        homeDirectory = "/home/${config.home.username}";
      };
    };
}
