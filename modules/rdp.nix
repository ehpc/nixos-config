{ pkgs, ... }:
{
  services.xrdp = {
    enable = true;
    openFirewall = false; # Managed with firewall module
    defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
  };

  services.gnome.gnome-remote-desktop.enable = true;

  systemd.services.gnome-remote-desktop = {
    wantedBy = [ "graphical.target" ];
  };

  services.displayManager.autoLogin.enable = false;
  services.getty.autologinUser = null;
}
