{ pkgsUnstable, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgsUnstable.vscode;
    profiles = {
      default = {
        extensions = with pkgsUnstable.vscode-extensions; [
          pkgsUnstable.vscode-extensions.jnoortheen.nix-ide
        ];
      };
    };
  };
}
