{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    
    wget
    curl
    
    net-tools
    pciutils
    lshw
    traceroute
  ];
}
