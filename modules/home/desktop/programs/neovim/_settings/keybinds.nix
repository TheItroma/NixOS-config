{
  vim.keymaps = [
    {
      key = "<leader>cd";
      mode = "n";
      action = ":Ex<CR>";
    }
    {
      key = "<leader>F";
      mode = "n";
      action = ":Neotree toggle filesystem right<CR>";
    }
    {
      key = "<leader>cc";
      mode = "n";
      action = ":CccPick<CR>";
    }
    {
      key = "<leader>d";
      mode = "n";
      action = ":<CR>";
    }
  ];
}
