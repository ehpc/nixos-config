{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    
    wget
    curl

    unzip
    ripgrep
    
    gparted
    net-tools
    pciutils
    lshw
    traceroute
    dig
  ];
}
