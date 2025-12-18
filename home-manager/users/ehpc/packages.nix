{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt

    # Package managers
    flatpak

    # Utilities
    dconf-editor
    nwipe
    nethogs

    # Social
    telegram-desktop
    discord
    qbittorrent

    # Browsers
    firefox
    google-chrome

    # Media
    vlc

    # Graphics
    clinfo
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    vulkan-tools-lunarg
    mesa-demos
    mangohud
  ];
}
