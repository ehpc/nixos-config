{
  config,
  pkgs,
  hostname,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
    ./desktop.nix
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
