{
  flake.modules.homeManager.neovim = {
    inputs,
    pkgs,
    ...
  }: {
    home.packages = with pkgs; [
      norgolith
    ];

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    programs.nvf = {
      enable = true;
      enableManpages = true; # man 5 nvf

      settings.imports = [
        ./_settings
      ];
    };
  };
}
