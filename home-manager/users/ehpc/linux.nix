{
  pkgs,
  isDarwin,
  username,
  email,
  ...
}:
{
  xdg.enable = true;

  imports = [
    (import ../../settings/sops.nix {
      inherit username;
    })
    ../../settings/dconf.nix
    ../../settings/mime.nix
    ../../programs/bash.nix
    ../../programs/starship.nix
    (import ../../programs/git.nix {
      inherit username email;
    })
    ../../programs/ssh.nix
    ../../programs/flatpak.nix
    ../../programs/gnome-shell.nix
    ../../programs/kitty.nix
    ../../programs/hyprland.nix
    ../../programs/nvim.nix
    ../../programs/vscode.nix
    ../../programs/zen-browser.nix
    ../../programs/qbittorrent
    (import ../../programs/mpv.nix {
      inherit isDarwin username;
    })
    ../../programs/chromium.nix
    ../../programs/restic.nix
    ../../programs/tailscale.nix
    ../../programs/davinci-resolve.nix
    ../../programs/obs.nix
    ../../programs/btop
    ../../programs/halloy.nix
  ];

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
    nasm
  ];
}
