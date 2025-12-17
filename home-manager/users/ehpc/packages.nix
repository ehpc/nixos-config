{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt
    nwipe

    flatpak

    dconf-editor

    # Social
    telegram-desktop
    discord

    # Browsers
    firefox
    google-chrome

    # Graphics
    clinfo
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    vulkan-tools-lunarg
    mesa-demos
  ];
}
