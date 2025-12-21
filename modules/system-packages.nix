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
    v4l-utils # qv4l2
  ];
}
