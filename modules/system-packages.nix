{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    
    wget
    curl

    unzip
    ripgrep
    
    net-tools
    pciutils
    lshw
    traceroute
  ];
}
