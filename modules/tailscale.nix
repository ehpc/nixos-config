{ config, ... }:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-routes"
      "--operator=ehpc"
      "--ssh"
    ];
  };

  # Run in the foreground so systemd owns the private route's lifetime.
  systemd.services.wherdr-serve = {
    description = "Private HTTPS access to wherdr over Tailscale";
    wantedBy = [ "multi-user.target" ];
    after = [
      "tailscaled.service"
      "tailscaled-set.service"
    ];
    requires = [ "tailscaled.service" ];
    partOf = [ "tailscaled.service" ];
    serviceConfig = {
      ExecStart = "${config.services.tailscale.package}/bin/tailscale serve --yes --https=7683 http://127.0.0.1:7683";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
