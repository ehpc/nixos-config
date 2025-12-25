{ ... }:
{
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
