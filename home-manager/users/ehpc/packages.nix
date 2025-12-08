{ pkgs, ... }:
{
  home.packages = [
    pkgs.nil
    pkgs.nixfmt
    pkgs.nwipe
  ];
}
