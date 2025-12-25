{ ... }:
{
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    interfaces.tailscale0 = {
      allowedTCPPorts = [
        3389
      ];
    };
  };
}
