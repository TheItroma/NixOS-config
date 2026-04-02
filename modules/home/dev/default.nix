{
  flake.modules.homeManager.dev = {
    lib,
    pkgs,
    config,
    ...
  }: {
    home.packages = with pkgs; [
      zig
      nmap
      zap
      metasploit
      hashcat
      foremost
      hping
      social-engineer-toolkit
      termshark
      aircrack-ng
    ];
  };
}
