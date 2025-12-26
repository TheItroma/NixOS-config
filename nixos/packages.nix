
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Hypr
    hyprsunset
    hyprpicker
    hyprshot

    # File managers
    yazi
    nemo
    
    # Text editors
    neovim
    obsidian

    # Graphics editor
    krita
    inkscape
    
    # Music making
    reaper
    ardour
    sfizz
    
    # Audio
    alsa-utils
    pavucontrol
    qpwgraph
    qjackctl
    
    # Players
    playerctl # Cli player controller
    rmpc # Customizable rust mpd tui
    mpd # Music player daemon
    spotify # Music player deamon and interface

    # Rice tui
    cava
    fastfetch
    tty-clock
    cmatrix
    cbonsai
    
    # Programing
    rustup
    
    # Game Dev
    godot
    unityhub
    blender
    
    # Privacy
    mullvad
    mullvad-vpn
    tor-browser
    librewolf
    
    # Wallpaper
    waypaper
    swww
    mpvpaper

    # Pywal
    pywal16
    pywalfox-native

    # Viewers
    zathura # PDF
    nomacs # Image

    # Communication
    weechat
    vesktop

    # Login
    sddm-sugar-dark
    kdePackages.sddm

    # Automation
    openrgb
    wtype

    # Video
    kdePackages.kdenlive # Editor
    obs-studio # Capture
    mpv # Player
    stremio # Player
    
    # CAD
    freecad-wayland
    kicad-small

    cura-appimage # 3D printing slicer
    tealdeer # Tldr command
    bat # A cat clone with wings
    git # Versionning
    dunst # Notifications
    bluetui # bluetooth
    protonup-qt # Gaming
    rofi # Launcher
    btop # Task manager
    qbittorrent # Torrenting
    kitty # Terminal
    cliphist # Clipboard
    wget # File fetcher
    clang # C/C++ compiler
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    nmap # A utility for network discovery and security auditing
    nix-output-monitor
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
    tree # I like it
    gamemode
    xwayland-satellite # XWayland support
  ];
}
