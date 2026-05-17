{ config, pkgs, lib, inputs, ... }:

{


  # Hyfetch configuration
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "transgender";
      mode = "rgb";
      color_align = {
        mode = "horizontal";
      };
    };
  };

  # Random utility programs
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.lsd.enable = true;

  # Configure vim
  programs.vim = {
    enable = true;
    settings = {
      tabstop = 2;
      shiftwidth = 4;
    };
  };


  # Kitty
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      confirm_os_window_close = 0;
      term = "xterm-kitty";
      enable_audio_bell = "no";
      scrollback_lines = 5000;
      linux_display_server = "wayland";
      background_opacity = 0.8;
      background_blur = 1;
    };
  };

  ##Use pwndbg for GDB
  #home.file.".gdbinit".text = let
  #  pwndbg = import "${inputs.pwndbg}/nix/pwndbg.nix" {
  #    inherit pkgs;
  #    inputs = inputs.pwndbg.inputs // {self = inputs.pwndbg;};
  #    gdb = pkgs.gdb; # - use vanilla nixpkgs' GDB instead of compiling your own ._.
  #  };
  #in ''
  #  source ${pwndbg}/share/pwndbg/gdbinit.py
  #'';
  programs.git = {
    enable = true;
    userName  = "Gian Klug";
    userEmail = "gian.klug@ict-scouts.ch";
  };
}


