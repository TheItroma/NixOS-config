
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

    # Automation
    openrgb
    wtype

    # Video
    kdePackages.kdenlive # Editor
    obs-studio # Capture
    mpv # Player
	# stremio # Player
    
    # CAD
    openscad-unstable
    freecad-wayland

    # VR
    slimevr # Trackers
    wlx-overlay-s # Vr desktop displayer
    wayvr-dashboard # Vr application launcher (replaces steamvr)
    vrc-get # Cli tool to inject vrc packages to unity
    alcom # UI for vrc-get
    xrizer # OpenVR -> OpenXR
    # xrbinder # To bind stuff

    # Gaming
    gamemode # Better performances or whatever
	# proton-ge-rtsp-bin # It was in the nixpkgs-xr overlay sooo
    protonup-qt # Just a gui for other proton installs
    umu-launcher # To use proton using non-steam games https://lvra.gitlab.io/docs/games/vr-no-steam/

    cura-appimage # 3D printing slicer
    dunst # Notifications
    bluetui # bluetooth
    rofi # Launcher
    qbittorrent # Torrenting
    kitty # Terminal
    cliphist # Clipboard
    nix-output-monitor
  ];
}
