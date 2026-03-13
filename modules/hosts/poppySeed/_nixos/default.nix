{
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "25.11";
  home-manager.home.stateVersion = "25.05";
}
