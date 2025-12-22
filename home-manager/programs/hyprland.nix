{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];

    settings = {
      "$mod" = "SUPER";

      "$menu" = "hyprlauncher";
      "$terminal" = "kitty";
      "$browser" = "zen";

      input = {
        kb_layout = "us,ru";
        kb_options = "grp:alt_shift_toggle";
      };

      bind = [
        "$mod, b, hyprexpo:expo, toggle"

        # Apps
        "$mod, SPACE, exec, $menu"
        "$mod, b, $browser"
        "$mod, t, $terminal"
      ];
    };
  };
}
