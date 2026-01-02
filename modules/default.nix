{
  self,
  config,
  pkgs,
  hostname,
  isDarwin,
  system,
  nixpkgs,
  ...
}:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    trusted-users = [ "ehpc" ];
  };

  nixpkgs.config.allowUnfree = true;

  imports =
    if isDarwin then
      [
        ./conf-darwin.nix
      ]
    else
      [
        ./conf-linux.nix
      ];
}
