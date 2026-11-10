{
  inputs,
  pkgs,
  ...
}:

{
  boot = {
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = [ "ntfs" ];
    consoleLogLevel = 3;
    initrd = {
      verbose = false;
      systemd.enable = true;
    };
    kernelParams = [
      "quiet"
      "splash"
      "intremap=on"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    plymouth = {
      enable = true;
      theme = "splash";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ "splash" ];
        })
      ];
    };
  };

  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    niri.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "ch";
    };
    displayManager.gdm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wofi
    kitty
    nautilus
    wdisplays
    networkmanagerapplet
    pavucontrol
    satty
    grimblast
    gimp
    inkscape
    clipse
    wl-clipboard-rs
    remmina
    gnome-network-displays
    kdePackages.kdenlive
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
