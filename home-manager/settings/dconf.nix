{ lib, ... }:
{
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      # GNOME powers down displays after 15 minutes; keep remote agents running.
      "org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 900;
      "org/gnome/settings-daemon/plugins/power" = {
        idle-dim = true;
        sleep-inactive-ac-type = "nothing";
      };
      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer"
          # "variable-refresh-rate"
          "xwayland-native-scaling"
        ];
      };
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
