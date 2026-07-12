{
  pkgs,
  pkgsUnstable,
  isDarwin,
  username,
  email,
  ...
}:
{
  imports = [
    (import ../../settings/sops.nix {
      inherit username;
    })
    (import ../../programs/mpv.nix {
      inherit isDarwin username;
    })
    (import ../../programs/claude {
      inherit pkgs pkgsUnstable username;
    })
  ];

  home.packages = with pkgs; [
    nil
    nixfmt

    # Dev
    binutils
    nasm
    docker_29

    # Disk management
    restic
    restic-browser

    # Remote
    moonlight-qt

    # Browsers
    firefox
    google-chrome
  ];
}
