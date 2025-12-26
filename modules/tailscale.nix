{ ... }:
{
  services.tailscale = {
    enable = true;
    extraSetFlags = [
      "--accept-routes"
      "--operator=ehpc"
      "--ssh"
    ];
  };
}
