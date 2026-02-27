{ inputs, config, ... }: {
  flake.modules.nixos.sops = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops.defaultSopsFile = ../../../../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/itroma/.config/sops.age.keys.txt";
  };
}
