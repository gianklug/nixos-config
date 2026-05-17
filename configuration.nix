# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.spicetify.nixosModules.spicetify
      #./home-manager.nix
    ];

  # Flaaaakes
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "giank" ];
  };


  #inputs.stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

  # boot settings
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.configurationLimit = 5;

    # ntfs-3g support
    supportedFilesystems = ["ntfs"]; 

    # make plymouth do plymouth things
    consoleLogLevel = 3;
    initrd.verbose = false;
    initrd.systemd.enable = true;
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
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "splash" ];
        })
      ];
    };
  };

  hardware.keyboard.qmk.enable = true;



  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
     font = "Lat2-Terminus16";
     useXkbConfig = true; # use xkb.options in tty.
  };



  # internet (tm)
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
      192.168.178.2 netbird.manabar.ch
      10.202.200.1 sso.int.tux42.local
    '';

  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # PCI power savings
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "powersupersave";

      # USB autosuspend to save power
      USB_AUTOSUSPEND = 1;

      # Sound power saving
      SOUND_POWER_SAVE_ON_BAT = 1;

      # SATA power management
      SATA_LINKPWR_ON_BAT = "min_power";
    };
  };
  services.fwupd.enable = true;
  services.blueman.enable = true;

  services.netbird.enable = true;


  # Printing
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };



  # Waylaaaand
  #services.displayManager.sddm = {
	#	enable = true;
	#	wayland.enable = true;
  #};

  # Binja flake
  # $ nix-store --add-fixed sha256 <path-to-installer>.zip
  programs.binary-ninja = {
    enable = true;
    package = pkgs.binary-ninja-personal-wayland;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
  #programs.hyprland = {
	#	enable = true;
	#	xwayland.enable = true;
  #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  #  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  #};

  # Niri
  programs.niri = {
    enable = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;

  # Thunderbolt
  services.hardware.bolt.enable = true;  

  # zsh (so the profile is happy)
  programs.zsh.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "ch";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.giank = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    home = "/home/giank";
    description = "Gian Klug";
    hashedPassword = "$y$j9T$ZUrmQWtp8n5qnzWE1IvfH1$6945HI7ShjquZk7x.D2N2Q8k1PitEcV8rdBPR3mrAQ0"; 
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  # Allow unfree software
  nixpkgs.config.allowUnfree = true; 

  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-sdk-6.0.428"
    "dotnet-runtime-6.0.36"
  ];

  programs.proxychains = {
    package = pkgs.proxychains-ng;
    enable = true;
    proxies = {
      prx1 = {
        type = "http";
        host = "172.30.3.254";
        port = "58080";
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # GUI
    discord
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
    inputs.zen-browser.packages."${system}".default
    inputs.burpsuitepro.packages.${system}.default
    threema-desktop
    spotify
    spicetify-cli
    telegram-desktop
    mixxx
    # CLI Tools
    vim 
    wget
    git
    btop
    pfetch-rs
    clipse
    ripgrep
    proxychains-ng
    wl-clipboard-rs
    file
    gnumake
    # Ruest Stuff
    zed-editor
    vscode
    cargo
    rustc
    # JavaScript
    nodejs_24
    bun
    # CTF
    (python312.withPackages (ps: with ps; [ pwntools ipython pycryptodome pip opencv4 pillow numpy scipy matplotlib fpylll cysignals pipx]))
    avalonia-ilspy
    apktool
    binwalk
    detect-it-easy
    exiftool
    gcc
    ghidra
    gobuster
    jadx
    jq
    netcat
    nmap
    #pwndbg
    patchelf
    pwntools
    pwninit
    sage
    sqlmap
    unzip
    winePackages.wayland
    wireshark
    zsteg
    # TF
    infracost
    opentofu
    packer
    qemu
    remmina
    gnome-network-displays
    kdePackages.kdenlive
    # Manabar
    netbird
    # Gstreamer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];

  # Nix-LD
  programs.nix-ld.enable = true;


  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  # Spotify ricing
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.text;
  };

  
  virtualisation.docker.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}
