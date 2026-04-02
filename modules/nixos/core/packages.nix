{
  flake.modules.nixos.core = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      # Archive utils
      unzip
      zip
      inetutils

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
      tinycc # A Tiny better C compiler
      yt-dlp # Yt downloader
      bat # A cat clone with wings
      tealdeer # Tldr command
      ffmpeg # Video Stuff
      picocom # More serial coms
      screen # For serial coms
    ];
  };
}
