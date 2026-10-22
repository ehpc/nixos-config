{ hostname, pkgs, lib, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-openconnect
      ];
    };
  };

  # Update only the existing profile; credentials stay in NetworkManager's state.
  systemd.services.wifi-stability = lib.mkIf (hostname == "ehpc-desktop") {
    description = "Pin home Wi-Fi to the stable 2.4 GHz radio";
    wantedBy = [ "multi-user.target" ];
    after = [ "NetworkManager.service" ];
    requires = [ "NetworkManager.service" ];
    partOf = [ "NetworkManager.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.networkmanager}/bin/nmcli connection modify uuid 6ba4853b-ef52-4935-8fe8-002c1e5068b2 802-11-wireless.band bg 802-11-wireless.bssid 60:CE:41:02:69:14";
    };
  };
}
