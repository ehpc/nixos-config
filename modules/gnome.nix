{ ... }:
{
  services.xserver.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome = {
    gnome-keyring.enable = true;
  };
}
