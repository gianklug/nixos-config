{ pkgs, ... }:

{
  services = {
    netbird.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
  };

  programs.proxychains = {
    package = pkgs.proxychains-ng;
    enable = true;
    proxies.prx1 = {
      type = "http";
      host = "172.30.3.254";
      port = "58080";
    };
  };

  environment.systemPackages = with pkgs; [
    netbird
    proxychains-ng
  ];
}
