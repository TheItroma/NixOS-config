{
  flake.modules.homeManager.desktop-programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      # File managers
      yazi
      nemo

      # Players
      playerctl # CLI player controller
      rmpc # Customizable rust mpd tui
      mpd # Music player daemon
      spotify # Music player deamon and interface

      # Privacy
      tor-browser

      # Wallpaper
      swww
      mpvpaper

      # Programing
      rustup

      # Office
      libreoffice-fresh
      kdePackages.calligra

      # Graphics editor
      #krita
      inkscape

      # Rice tui
      cava
      fastfetch
      tty-clock
      cmatrix
      cbonsai

      # Game Dev
      godot
      unityhub
      blender

      # Viewers
      zathura # PDF
      nomacs # Image

      # Automation
      openrgb
      wtype

      # Video kdePackages.kdenlive # Editor
      obs-studio # Capture
      mpv # Player

      # CAD
      openscad-unstable
      #freecad-wayland

      cura-appimage # 3D printing slicer
      dunst # Notifications
      bluetui # bluetooth
      rofi # Launcher
      qbittorrent # Torrenting
      cliphist # Clipboard
      nix-output-monitor
      weechat # Irc and Matrix tui
      obsidian # Text editors
      mumble # Voice chat client
      wiremix # Simple TUI mixer for PipeWire
      pass # Password manager
      calligraphy # Does cool ASCII banners
      calcure # Tui Calendar with vim bindings
      calcurse # The one on top or this one?
      bagels # Tui expense tracker
      asak # Tui audio recorder
      kicad-unstable
      ungoogled-chromium # for messenger
    ];
  };
}
