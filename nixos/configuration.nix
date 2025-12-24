# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
    ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.niri.enable = true;
  programs.steam.enable = true;


  hardware.graphics = {
    enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
  services.blueman.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
	    # "qtwebengine-5.15.19"
      "mbedtls-2.28.10"
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use stable/default kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos";

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.mullvad-vpn.enable = true;

  time.timeZone = "Canada/Eastern";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };


  users.users.itroma = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };


  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  system.stateVersion = "25.05"; # Did you read the comment?

}
