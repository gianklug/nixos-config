{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    #(nerdfonts.override { fonts = ["ComicShannsMono"]; })
    nerd-fonts.comic-shanns-mono
    # You can add more packages here
    adwaita-icon-theme
  ];
}
