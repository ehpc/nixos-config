{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    profiles = {
      default = {
        extensions = with pkgs.vscode-extensions; [
          pkgs.vscode-extensions.jnoortheen.nix-ide
        ];
      };
    };
  };
}
