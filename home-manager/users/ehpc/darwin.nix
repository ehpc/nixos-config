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
    ../../programs/kitty.nix
    ../../programs/zsh.nix
  ];

  home.packages = with pkgs; [
    nil
    nixfmt

    # Dev
    binutils
    nasm
    docker_29
    pkgsUnstable.dbeaver-bin

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
