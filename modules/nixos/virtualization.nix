{ config, ... }:

{
  virtualisation = {
    docker.enable = true;
    virtualbox.host.enable = true;
  };

  users.users.${config.local.primaryUser.name}.extraGroups = [
    "docker"
    "vboxusers"
  ];
}
