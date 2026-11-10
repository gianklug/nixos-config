{ ... }:

{
  imports = [ ./core.nix ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
