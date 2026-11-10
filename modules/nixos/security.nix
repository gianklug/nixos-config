{
  inputs,
  pkgs,
  ...
}:

let
  python313NoDocs = pkgs.python313.overrideAttrs (_: {
    outputs = [
      "out"
      "dev"
    ];
  });
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
  ];

  environment.systemPackages = with pkgs; [
    inputs.burpsuitepro.packages.${pkgs.stdenv.hostPlatform.system}.default
    (python313NoDocs.withPackages (
      ps: with ps; [
        pwntools
        ipython
        pycryptodome
        pip
        opencv4
        pillow
        numpy
        scipy
        matplotlib
        fpylll
        cysignals
        (pipx.overrideAttrs (old: {
          disabledTestPaths = (old.disabledTestPaths or [ ]) ++ [
            "tests/test_package_specifier.py"
          ];
        }))
      ]
    ))
    avalonia-ilspy
    apktool
    binwalk
    detect-it-easy
    exiftool
    gcc
    ghidra
    gobuster
    jadx
    netcat
    nmap
    patchelf
    pwntools
    pwninit
    sage
    sqlmap
    winePackages.wayland
    wireshark
    zsteg
  ];
}
