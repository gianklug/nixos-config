{ config, pkgs, lib, inputs, ... }:

{
    imports = [
      ./home/packages.nix
      ./home/theme.nix
      ./home/shell.nix
      ./home/hyprland.nix
      ./home/waybar.nix
      ./home/swaync.nix
      ./home/wofi.nix
      ./home/programs.nix
    ];
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
}
