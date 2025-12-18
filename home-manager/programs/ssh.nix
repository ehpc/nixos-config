{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
    };
  };
  home.activation.fixSshConfigPermissions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.ssh"
    run chmod 700 "$HOME/.ssh"

    if [ -L "$HOME/.ssh/config" ]; then
      src="$(readlink -f "$HOME/.ssh/config")"
      if [ -f "$src" ]; then
        run rm -f "$HOME/.ssh/config"
        run install -m600 "$src" "$HOME/.ssh/config"
      fi
    fi
  '';
}
