{
  flake.modules.homeManager.neovim = { inputs, ... }: {

    #environment.variables.EDITOR = "${programs.nvf.finalPackage}/bin/nvim";

    programs.nvf = {
      enable = true;
      enableManpages = true; # man 5 nvf

      settings.imports = [
        ./_settings
      ];
    };
  };
}
