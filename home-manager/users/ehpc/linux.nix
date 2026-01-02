{
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
    ./packages.nix
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
      inherit username;
    })
    ../../programs/chromium.nix
    ../../programs/restic.nix
    ../../programs/tailscale.nix
    ../../programs/davinci-resolve.nix
    ../../programs/obs.nix
    ../../programs/btop
    ../../programs/halloy.nix
  ];
}
