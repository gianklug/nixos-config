{ pkgs, ... }:

{
  # Binary Ninja is intentionally enabled only on this host. The package is
  # a gated download and must be added to the Nix store manually first.
  programs.binary-ninja = {
    enable = true;
    package = pkgs.binary-ninja-personal-wayland;
  };
}
