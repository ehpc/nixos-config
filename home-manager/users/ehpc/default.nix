{ config, pkgs, ... }:
let
  username = "ehpc";
  email = "ehpc@ehpc.io";
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  xdg.enable = true;

  imports = [
    ../../settings/dconf.nix
    ../../settings/mime.nix
    ./packages.nix
    (import ../../programs/git.nix {
      inherit username email;
    })
    ../../programs/ssh.nix
    ../../programs/flatpak.nix
    # ../../programs/hyprland.nix
    ../../programs/nvim.nix
    ../../programs/vscode.nix
    ../../programs/zen-browser.nix
    ../../programs/qbittorrent
    ../../programs/mpv.nix
  ];
}
