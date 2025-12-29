{ pkgs, pkgsUnstable, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt

    # Devices
    evhz
    piper
    v4l-utils # qv4l2

    # Package managers
    flatpak

    # Disk management
    restic
    restic-browser
    veracrypt
    cryptomator

    # Utilities
    wl-clipboard
    dconf-editor
    nwipe
    nethogs
    cpu-x
    remmina
    grim
    slurp
    age
    sops

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
    calibre

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
    ffmpeg

    # Audio
    pavucontrol
    pwvucontrol
    bitwig-studio
    yabridge
    yabridgectl

    # Photo
    gphoto2

    # Drawing
    krita
    gimp
    inkscape
    pinta

    # Dev
    dbeaver-bin
  ];
}
