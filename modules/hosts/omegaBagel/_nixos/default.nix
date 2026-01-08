{
  imports = [
    ./hardware.nix
  ];

  time.hardwareClockInLocalTime = true;

  system.stateVersion = "25.05";
}
