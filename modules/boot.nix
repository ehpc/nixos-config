{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelParams = [
      "preempt=full"
      "threadirqs"
    ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "fs.inotify.max_user_watches" = 1048576;
    };
  };
}
