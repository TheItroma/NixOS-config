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
        #username = "itroma"; # change back to primaryUser
      };
    };
}
