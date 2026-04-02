{lib, ...}: {
  vim = {
    languages = {
      # Little tip :
      #   Enter visual mode then selecting the list
      #   Enter command mode and type !sort
      #   Will instantly sort the list (on linux).
      # I FUCKING LOVE COREUTILS SO MUCH

      enableFormat = true;
      enableTreesitter = true;

      bash.enable = true;
      clang.enable = true;
      cmake.enable = true;
      csharp.enable = true;
      css.enable = true;
      glsl.enable = true;
      go.enable = true;
      html.enable = true;
      json.enable = true;
      lua.enable = true;
      make.enable = true;
      markdown.enable = true;
      nix.enable = true;
      python.enable = true;
      toml.enable = true;
      ts.enable = true;
      typst.enable = true;
      xml.enable = true;
      zig.enable = true;

      rust = {
        enable = true;
        extensions.crates-nvim.enable = true;
      };
    };
  };
}
