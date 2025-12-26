{ inputs , lib , config , pkgs , ... }: {

  imports = [
    ./niri/default.nix
    ./hyprland/default.nix
  ];

  services.polkit-gnome.enable = true;
  programs.waybar.enable = true;


  home = {
   username = "itroma";
    homeDirectory = "/home/itroma";
  };

  programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "TheItroma";
    userEmail = "edmondliseuse@gmail.com";
  };
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
