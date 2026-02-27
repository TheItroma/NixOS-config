{
  flake.modules.homeManager.neovim = { inputs, lib, ... }: {

    #environment.variables.EDITOR = "${programs.nvf.finalPackage}/bin/nvim";

    imports = [
      inputs.nvf.nixosModules.default
      # Ok, this is kinda really stupid but whatever
      (lib.attrsets.setAttrByPath ["programs" "nvf" "settings"] (import ./_settings))
    ];

    programs.nvf = {
      enable = true;
      enableManpages = true; # man 5 nvf
    };
  };
}
