
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tealdeer # Tldr command
    bat # A cat clone with wings
    git # Versionning
    btop # Task manager
    wget # File fetcher
    clang # C/C++ compiler
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    nmap # A utility for network discovery and security auditing
    lm_sensors # for `sensors` command
    pciutils # lspci
    usbutils # lsusb
    tree # I like it
  ];
}
