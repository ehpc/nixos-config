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
  };
}
