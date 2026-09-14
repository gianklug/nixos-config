{ pkgs, ... }:

{
  networking.hostName = "travel";

  # Intel UHD graphics (PCI device 8086:3ea0) on the local seat.
  boot.kernelModules = [ "i915" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  # Start Hyprland from GDM on the local seat, not from an SSH/TTY session.
  services.displayManager.defaultSession = "hyprland";

  # Required for reconnecting after nixos-anywhere reboots the machine.
  services.openssh.enable = true;

  # Replace this with the key used to administer travel.
  users.users.giank.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvZc3xe0NNikoO5Opa1ebGhSH65OKrmFF5X4sMZIW0ufsY5Zha1rtM+tuVVfmu7qT5qzVqdpYpPCPLUlX+PL8wHxSyc+lvvcK53cvr/oHqRsbL8Fv/s+DTCCQQwL+tZu3sDXJkUPp097hsms9TckIENiMgbAH/BiQxQ2mCw6N7P9E1d8igkwiyjDM8J83R5cHG9Y1Ja4t5f8afJ+UnUG7yI8B0S3knvFGjWOH2Q5SdfQOUxSKnGbRXbxjRNSwjTHfqXauSN8f/DKOueI8VqPXP/9/CNoywwhgN5FwCkbjCelnfdFgUh1GkJOswXElg7wt9y/ZmR1/N8jCwXkyRZmZVtNsU15bumfADfDXPTo62Zdc8cBw3+fdWBYBi5lFmp1ibtg2I6arw8mKvK6K2hdvcFlZIAVhZoeyBWLkQBZDK5dv9+ojJcq2VehKMtePuCF/snXGJuAUwX5PDfNlMDzBc+tK/vqtmHk+43IHVvm0pCdNlfyGzyMYzV6ye4ccg/Gs= giank@just-ubuntu"
  ];
}
