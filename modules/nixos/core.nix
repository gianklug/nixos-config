{
  pkgs,
  ...
}:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Zurich";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  networking = {
    networkmanager.enable = true;
    extraHosts = ''
      192.168.178.2 netbird.manabar.ch
      10.202.200.1 sso.int.tux42.local
    '';
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    btop
    pfetch-rs
    ripgrep
    file
    gnumake
    jq
    unzip
  ];

  system.stateVersion = "24.11";
}
