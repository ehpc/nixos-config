{ config, ... }:
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

    kernelModules = [ "v4l2loopback" ];

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];

    extraModprobeConfig = ''
      options v4l2loopback devices=2 video_nr=1,2 card_label="OBS Cam, Virt Cam" exclusive_caps=1
    '';
  };
}
