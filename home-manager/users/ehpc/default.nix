{ config, pkgs, ... }:
let
  username = "ehpc";
  email = "ehpc@ehpc.io";
in
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  home.packages = [
    pkgs.nil
    pkgs.nixfmt
  ];

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

  imports = [
    ../../programs/nvim.nix
    ../../programs/vscode.nix
  ];
}
