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
      inherit username;
    })
  ];

  home.packages = with pkgs; [
    nil
    nixfmt
  ];
}
