{
  flake.modules.homeManager.desktop-programs = {pkgs, ...}: {
    home.packages = with pkgs; [
      spotify
      # Organisation
      calcure # Tui Calendar with vim bindings
      calcurse # The one on top or this one?
      tomato-c # Simple pomodoro application
      glow # CLI md viewer

      # File managers
      yazi
      nemo

      # Players
      playerctl # CLI player controller
      rmpc # Customizable rust mpd tui
      mpd # Music player daemon
      #spotify # Music player deamon and interface

      # Privacy
      tor-browser

      # Wallpaper
      awww
      mpvpaper

      # Programing
      rustup

      # Office
      libreoffice-fresh
      kdePackages.calligra

      # Rice tui
      cava
      fastfetch
      tty-clock
      clock-rs
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
      freecad-wayland

      # Torrenting
      qbittorrent # GUI
      stig # CLI/TUI
      transmission_4

      # Image stuff
      gimp
      imagemagick # need dat
      exiftool # Metadata tool
      darktable # Photographer tool for image editing
      krita
      inkscape

      cura-appimage # 3D printing slicer
      dunst # Notifications
      bluetui # bluetooth
      rofi # Launcher
      cliphist # Clipboard
      nix-output-monitor
      weechat # Irc and Matrix tui
      mumble # Voice chat client
      wiremix # Simple TUI mixer for PipeWire
      calligraphy # Does cool ASCII banners
      bagels # Tui expense tracker
      asak # Tui audio recorder
      kicad-unstable
      ungoogled-chromium # for messenger
      miktex # Latex
    ];
  };
}
