{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 50;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };
}
