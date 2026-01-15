{
  pkgs,
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
  ];

  home.packages = with pkgs; [
    nil
    nixfmt

    # Dev
    binutils
    nasm
    docker
    colima

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
