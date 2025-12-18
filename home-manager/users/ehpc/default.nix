{ config, pkgs, ... }:
let
  username = "ehpc";
  email = "ehpc@ehpc.io";
  mediaPlayers = [ "mpv.desktop" ];
  browsers = [ "zen-beta.desktop" ];
  associations = {
    "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
    "x-scheme-handler/http" = browsers;
    "x-scheme-handler/https" = browsers;
    "x-scheme-handler/chrome" = browsers;
    "text/html" = browsers;
    "application/x-extension-htm" = browsers;
    "application/x-extension-html" = browsers;
    "application/x-extension-shtml" = browsers;
    "application/xhtml+xml" = browsers;
    "application/x-extension-xhtml" = browsers;
    "application/x-extension-xht" = browsers;
    "audio/*" = mediaPlayers;
    "video/*" = mediaPlayers;
  };
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            name = username;
            email = email;
          };
          init = {
            defaultBranch = "main";
          };
        };
      }
    ];
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    settings."org/gnome/mutter" = {
      experimental-features = [
        "scale-monitor-framebuffer"
        # "variable-refresh-rate"
        "xwayland-native-scaling"
      ];
    };
    settings."org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        hibernate-status-button.extensionUuid
        appindicator.extensionUuid
      ];
    };
  };

  xdg.enable = true;

  xdg.mimeApps.enable = true;
  xdg.mimeApps.associations.added = associations;
  xdg.mimeApps.defaultApplications = associations;

  imports = [
    ./packages.nix
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
