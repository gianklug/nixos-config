{
  inputs,
  lib,
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
    inputs.disko.nixosModules.disko
    ./disko.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "travel";

  local.primaryUser = {
    name = "giank";
    hashedPassword = "$y$j9T$ZUrmQWtp8n5qnzWE1IvfH1$6945HI7ShjquZk7x.D2N2Q8k1PitEcV8rdBPR3mrAQ0";
  };

  # Intel UHD graphics (PCI device 8086:3ea0) on the local seat.
  boot.kernelModules = [ "i915" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  # Use a TTY greeter to avoid GDM's DRM handoff triggering Aquamarine's
  # atomic modeset bug on the Intel GPU and DP-MST dock.
  services.displayManager.gdm.enable = lib.mkForce false;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --cmd start-hyprland";
      user = "greeter";
    };
  };

  # Required for reconnecting after nixos-anywhere reboots the machine.
  services.openssh.enable = true;

  # Replace this with the key used to administer travel.
  users.users.giank.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvZc3xe0NNikoO5Opa1ebGhSH65OKrmFF5X4sMZIW0ufsY5Zha1rtM+tuVVfmu7qT5qzVqdpYpPCPLUlX+PL8wHxSyc+lvvcK53cvr/oHqRsbL8Fv/s+DTCCQQwL+tZu3sDXJkUPp097hsms9TckIENiMgbAH/BiQxQ2mCw6N7P9E1d8igkwiyjDM8J83R5cHG9Y1Ja4t5f8afJ+UnUG7yI8B0S3knvFGjWOH2Q5SdfQOUxSKnGbRXbxjRNSwjTHfqXauSN8f/DKOueI8VqPXP/9/CNoywwhgN5FwCkbjCelnfdFgUh1GkJOswXElg7wt9y/ZmR1/N8jCwXkyRZmZVtNsU15bumfADfDXPTo62Zdc8cBw3+fdWBYBi5lFmp1ibtg2I6arw8mKvK6K2hdvcFlZIAVhZoeyBWLkQBZDK5dv9+ojJcq2VehKMtePuCF/snXGJuAUwX5PDfNlMDzBc+tK/vqtmHk+43IHVvm0pCdNlfyGzyMYzV6ye4ccg/Gs= giank@just-ubuntu"
  ];
}
