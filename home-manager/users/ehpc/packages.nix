{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt

    # Devices
    evhz
    piper

    # Package managers
    flatpak

    # Disk management
    restic
    restic-browser
    veracrypt
    cryptomator

    # Utilities
    dconf-editor
    nwipe
    nethogs
    cpu-x

    # Social
    telegram-desktop
    discord
    qbittorrent
    signal-desktop
    zapzap
    teams-for-linux

    # Browsers
    firefox
    google-chrome

    # Media
    vlc

    # Productivity
    obsidian

    # Graphics
    clinfo
    libva-utils
    vulkan-headers
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    vulkan-tools-lunarg
    mesa-demos
    mangohud
    radeontop

    # Audio
    pavucontrol
    pwvucontrol

    # Drawing
    krita
  ];
}
