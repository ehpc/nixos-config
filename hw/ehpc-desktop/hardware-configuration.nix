{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [
    "dm-snapshot"
    "cryptd"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.resumeDevice = "/dev/dm-1";

  fileSystems."/" = {
    device = "/dev/disk/by-label/NixOS-Root";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-label/NixOS-Encrypted";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-label/NixOS-EFI";
    fsType = "vfat";
    options = [ "umask=077" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-label/NixOS-Swap"; }
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/home/ehpc/data1tb" = {
    device = "/dev/disk/by-label/Data1Tb";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "dmask=022"
      "fmask=133"
    ];
  };

  fileSystems."/home/ehpc/data2tb" = {
    device = "/dev/disk/by-label/Data2Tb";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1000"
      "gid=100"
      "dmask=022"
      "fmask=133"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
