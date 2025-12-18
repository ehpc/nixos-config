{ pkgs, ... }:
{
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        # "variable-refresh-rate"
        "xwayland-native-scaling"
      ];
    };
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        hibernate-status-button.extensionUuid
        appindicator.extensionUuid
      ];
    };
  };
}
