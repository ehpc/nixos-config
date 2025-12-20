{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          pkgs.vscode-extensions.jnoortheen.nix-ide
        ];
      };
    };
  };
}
