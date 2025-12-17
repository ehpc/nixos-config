{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    
    wget
    curl

    pciutils
    lshw
    traceroute
  ];
}
