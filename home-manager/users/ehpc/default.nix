{
  config,
  pkgs,
  isDarwin,
  ...
}:
let
  username = "ehpc";
  email = "ehpc@ehpc.io";
in
{
  home.username = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  imports =
    if isDarwin then
      [
        (import ./darwin.nix {
          inherit pkgs username email;
        })
      ]
    else
      [
        (import ./linux.nix {
          inherit pkgs username email;
        })
      ];
}
