{
  flake.modules.nixos.core = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      # Archive utils
      unzip
      zip

      # Search and listing
      ripgrep # recursively searches directories for a regex pattern
      fzf # A command-line fuzzy finder
      tree # Ls but in tree format

      # System information
      btop # Task manager
      lm_sensors # for `sensors` command
      usbutils # lsusb
      pciutils # lspci

      # Fetchers
      wget # File fetcher

      # Misc
      nmap # A utility for network discovery and security auditing
      clang # C/C++ compiler
      bat # A cat clone with wings
      tealdeer # Tldr command
      picocom # More serial coms
      screen # For serial coms
      git # Versionning and fetcher
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
