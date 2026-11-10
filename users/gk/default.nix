{ homeModules, ... }:

{
  imports = [
    homeModules.cli
    homeModules.desktop
    homeModules.editors
    homeModules.shell
    homeModules.terminal
  ];

  home.stateVersion = "24.11";
}
