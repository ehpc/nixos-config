{ ... }:
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome = {
    gnome-keyring.enable = true;
  };
}
