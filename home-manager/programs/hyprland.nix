{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];

    extraConfig = ''
      bind = SUPER, g, hyprexpo:expo, toggle
    '';
  };
}
