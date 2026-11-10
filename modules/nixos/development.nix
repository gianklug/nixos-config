{ pkgs, ... }:

let
  vscode = pkgs.vscode.overrideAttrs (old: {
    postPatch =
      builtins.replaceStrings
        [
          "rm resources/app/node_modules/@vscode/ripgrep/bin/rg"
          "ln -s ${pkgs.ripgrep}/bin/rg resources/app/node_modules/@vscode/ripgrep/bin/rg"
        ]
        [
          "rm -f resources/app/node_modules/@vscode/ripgrep/bin/rg"
          ''
            mkdir -p resources/app/node_modules/@vscode/ripgrep/bin
            ln -s ${pkgs.ripgrep}/bin/rg resources/app/node_modules/@vscode/ripgrep/bin/rg
          ''
        ]
        old.postPatch;
  });
in

{
  programs.nix-ld.enable = true;

  environment.systemPackages = [
    pkgs.zed-editor
    vscode
    pkgs.cargo
    pkgs.rustc
    pkgs.nodejs_24
    pkgs.bun
    pkgs.infracost
    pkgs.opentofu
    pkgs.qemu
    pkgs.vagrant
  ];
}
