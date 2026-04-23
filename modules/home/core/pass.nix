{
  flake.modules.homeManager.pass = {pkgs, ...}: {
    home.packages = with pkgs; [
      sops
      pass
      passExtensions.pass-otp
    ];
  };
}
