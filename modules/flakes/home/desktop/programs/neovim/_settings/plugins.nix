{
  vim = {
    lazy.plugins = {
      smear-cursor.nvim = {
        package = smear-cursor;
      };
    };

    autopairs.nvim-autopairs.enable = true;
    utility.undotree.enable = true;
    git.enable = true;

    statusline.lualine = {
      enable = true;
    };
    formatter.confirm-nvim = {
      enable = true;
    };
    autocomplete.blink-cmp = {
      enable = true;
    };
    telescope = {
      enable = true;
    };
    treesitter = {
      enable = true;
    };
    visuals = {
      nvim-cursorline.enable = true;

      indent-blankline = {
        enable = true;
      };
    };
    mini = {
      cursorword.enable = true;

      animate = {
        enable = true;
        setupOpts = {
          cursor.enable = false;
        };
      };
    };
  };
}
