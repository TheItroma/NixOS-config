{ pkgs, ... }: {
    home.packages = with pkgs; [
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

	# Gaming
	protonup-qt # Proton
	gamescope
	gamemode

	# Other
	dunst # Notifications
	bluetui # bluetooth
	rofi # Launcher
	qbittorrent # Torrenting
	kitty # Terminal
	cliphist # Clipboard
	nix-output-monitor
    ];
}
