{
  inputs,
  lib,
  ...
}:

let
  discover =
    directory:
    let
      entries = builtins.readDir directory;
    in
    builtins.listToAttrs (
      lib.concatMap (
        entry:
        let
          type = entries.${entry};
          path = directory + "/${entry}";
        in
        if type == "regular" && lib.hasSuffix ".nix" entry then
          [ (lib.nameValuePair (lib.removeSuffix ".nix" entry) path) ]
        else if type == "directory" && builtins.pathExists (path + "/default.nix") then
          [ (lib.nameValuePair entry (path + "/default.nix")) ]
        else
          [ ]
      ) (builtins.attrNames entries)
    );

  hosts = discover ./hosts;
  homeModules = discover ./modules/home;
  homeProfiles = discover ./users;
  nixosModules = discover ./modules/nixos;

  mkHost =
    name: hostModule:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          homeModules
          homeProfiles
          inputs
          nixosModules
          ;
      };

      modules = [
        inputs.home-manager.nixosModules.home-manager
        nixosModules.default
        hostModule
        {
          networking.hostName = lib.mkDefault name;
          home-manager.extraSpecialArgs = {
            inherit inputs homeModules;
          };
        }
      ];
    };
in
{
  systems = [ "x86_64-linux" ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.nixfmt-tree;
    };

  flake = {
    inherit homeModules nixosModules;
    nixosConfigurations = lib.mapAttrs mkHost hosts;
  };
}
