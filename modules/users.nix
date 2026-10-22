{ isDarwin, ... }:
{
  users.users.ehpc =
    if isDarwin then
      {
        description = "ehpc";
        home = "/Users/ehpc";
      }
    else
      {
        isNormalUser = true;
        # Start user services, including wherdr, at boot and keep them after logout.
        linger = true;
        description = "ehpc";
        home = "/home/ehpc";
        extraGroups = [
          "networkmanager"
          "wheel"
          "tss"
          "gamemode"
          "qbittorrent"
          "audio"
          "rtkit"
          "yandexdisk"
          "docker"
          "libvirtd"
        ];
      };
}
