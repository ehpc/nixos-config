{
  pkgs,
  pkgsUnstable,
  isDarwin,
  username,
  email,
  ...
}:
{
  xdg.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
    ];
  };

  imports = [
    (import ../../settings/sops.nix {
      inherit username;
    })
    ../../settings/dconf.nix
    ../../settings/mime.nix
    ../../programs/bash.nix
    (import ../../programs/python.nix {
      inherit pkgs pkgsUnstable;
    })
    ../../programs/starship.nix
    (import ../../programs/git.nix {
      inherit username email;
    })
    ../../programs/ssh.nix
    ../../programs/flatpak.nix
    ../../programs/gnome-shell.nix
    ../../programs/kitty.nix
    ../../programs/hyprland.nix
    ../../programs/distrobox.nix
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
    ../../programs/friture.nix
    ../../programs/obs.nix
    ../../programs/btop
    ../../programs/halloy.nix
    ../../programs/timidity.nix
    ../../programs/fluidsynth.nix
    ../../programs/dropbox.nix
    (import ../../programs/claude {
      inherit pkgs pkgsUnstable username;
    })
  ];

  home.packages = with pkgs; [
    nil
    nixfmt

    # Devices
    evhz
    piper
    v4l-utils # qv4l2
    dnsmasq

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
    jq
    ripgrep
    fd
    tree
    usbutils

    # Social
    telegram-desktop
    discord
    qbittorrent
    signal-desktop
    zapzap
    teams-for-linux

    # Browsers
    firefox
    (wrapFirefox (firefox-unwrapped.override { pipewireSupport = true; }) { })
    google-chrome

    # Media
    vlc

    # Productivity
    obsidian
    calibre
    libreoffice

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
    oxipng
    pngquant

    # Audio
    pavucontrol
    pwvucontrol
    yabridge
    yabridgectl
    aubio
    pkgsUnstable.bitwig-studio
    pkgsUnstable.tony
    pkgsUnstable.audacity
    pkgsUnstable.nootka
    pkgsUnstable.solfege
    pkgsUnstable.ultrastardx
    pkgsUnstable.performous
    pkgsUnstable.vmpk
    pkgsUnstable.musescore
    pkgsUnstable.lmms
    pkgsUnstable.fluidsynth
    pkgsUnstable.demucs-rs
    pkgsUnstable.yt-dlp
    audio-separator
    praat
    vamp-plugin-sdk
    sonic-visualiser
    pkgsUnstable.rubberband
    pkgsUnstable.sox
    pkgsUnstable.jamulus

    # Photo
    gphoto2
    pkgsUnstable.darktable
    pkgsUnstable.hugin

    # Video
    pkgsUnstable.kdePackages.kdenlive
    pkgsUnstable.handbrake

    # Drawing
    krita
    gimp
    inkscape
    pinta

    # Dev
    pkgsUnstable.dbeaver-bin
    pkgsUnstable.nasm
    pkgsUnstable.claude-code
    playwright-cli
    pkgsUnstable.onnxruntime
    gh

    # Virtualization
    bottles
  ];
}
