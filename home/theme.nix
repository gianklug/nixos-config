{ config, pkgs, lib, ... }:

{
  # Enable GTK theme settings
  gtk = {
    enable = true;
    # Preserve the pre-26.05 GTK4 theme default.
    gtk4.theme = config.gtk.theme;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  # Set environment variable for dark mode where supported
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };

  # Optional: Use gsettings to enforce dark mode for GNOME apps
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 32;
  };
}
