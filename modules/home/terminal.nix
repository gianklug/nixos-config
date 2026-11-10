{ ... }:
{
  # Kitty
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "ctrl+," = "change_font_size all +1.0";
      "ctrl+-" = "change_font_size all -1.0";
      "ctrl+0" = "change_font_size all 0";
    };
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

}
