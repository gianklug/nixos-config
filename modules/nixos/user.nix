{
  config,
  homeProfiles,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.local.primaryUser;
in
{
  options.local.primaryUser = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Primary local user account";
    };

    description = lib.mkOption {
      type = lib.types.str;
      default = "gk";
      description = "Display name for the primary local user";
    };

    hashedPassword = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Initial hashed password, if managed declaratively";
    };

    profile = lib.mkOption {
      type = lib.types.enum (builtins.attrNames homeProfiles);
      default = "gk";
      description = "Home Manager profile from the users directory";
    };
  };

  config = {
    nix.settings.trusted-users = [ cfg.name ];

    users.users.${cfg.name} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      home = "/home/${cfg.name}";
      inherit (cfg) description hashedPassword;
      shell = pkgs.zsh;
    };

    home-manager.users.${cfg.name}.imports = [ homeProfiles.${cfg.profile} ];
  };
}
