{ ... }:

{
  hardware.keyboard.qmk.enable = true;

  services = {
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersupersave";
        USB_AUTOSUSPEND = 1;
        SOUND_POWER_SAVE_ON_BAT = 1;
        SATA_LINKPWR_ON_BAT = "min_power";
      };
    };
    fwupd.enable = true;
    blueman.enable = true;
    hardware.bolt.enable = true;
  };
}
