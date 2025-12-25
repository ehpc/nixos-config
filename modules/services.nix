{ ... }:
{
  services.flatpak.enable = true;
  services.ratbagd.enable = true;
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--accept-routes"
      "--operator=ehpc"
    ];
  };
}
