{
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.spicetify.nixosModules.spicetify ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    spicetify = {
      enable = true;
      theme = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.text;
    };
  };

  environment.systemPackages = with pkgs; [
    discord
    threema-desktop
    spotify
    spicetify-cli
    telegram-desktop
    mixxx
  ];
}
