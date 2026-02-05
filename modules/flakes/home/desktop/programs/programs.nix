{
  flake.modules.homeManager.desktop-programs =
    { pkgs, ... }: {
      home.packages = with pkgs; [
	neovim
        # File managers
        yazi
        nemo

        # Players
        playerctl # Cli player controller
        rmpc # Customizable rust mpd tui
        mpd # Music player daemon
        spotify # Music player deamon and interface
        
        # Privacy
        mullvad-vpn
        tor-browser
        librewolf

        # Wallpaper
        waypaper
        swww
        mpvpaper

        # Programing
        rustup

        # Graphics editor
        krita
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
        freecad-wayland

        cura-appimage # 3D printing slicer
        dunst # Notifications
        bluetui # bluetooth
        rofi # Launcher
        qbittorrent # Torrenting
        cliphist # Clipboard
        nix-output-monitor
        pywal16 # Color palet generator
        weechat # Irc and Matrix tui
        obsidian # Text editors
      ];
    };
}
