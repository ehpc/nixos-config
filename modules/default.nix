{
  config,
  pkgs,
  hostname,
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

  imports = [
    ../hw/${hostname}/hardware-configuration.nix
    ./boot.nix
    ./network.nix
    ./time.nix
    ./locale.nix
    ./security.nix
    ./encryption.nix
    ./system-packages.nix
    ./users.nix
    ./audio.nix
    ./printing.nix
    ./keyboard.nix
    ./desktop
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
