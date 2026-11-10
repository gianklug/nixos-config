{
  inputs,
  nixosModules,
  pkgs,
  ...
}:

{
  imports = [
    nixosModules.desktop
    nixosModules.development
    nixosModules.laptop
    nixosModules.personal
    nixosModules.security
    nixosModules.services
    nixosModules.user
    nixosModules.virtualization
    inputs.binaryninja.nixosModules.binaryninja
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  local.primaryUser = {
    name = "gk";
    hashedPassword = "$y$j9T$ZUrmQWtp8n5qnzWE1IvfH1$6945HI7ShjquZk7x.D2N2Q8k1PitEcV8rdBPR3mrAQ0";
  };

  # Binary Ninja is intentionally enabled only on this host. The package is
  # a gated download and must be added to the Nix store manually first.
  programs.binary-ninja = {
    enable = true;
    package = pkgs.binary-ninja-personal-wayland;
  };
}
