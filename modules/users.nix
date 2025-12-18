{ ... }:
{
  users.users.ehpc = {
    isNormalUser = true;
    description = "ehpc";
    extraGroups = [
      "networkmanager"
      "wheel"
      "tss"
      "gamemode"
      "qbittorrent"
    ];
  };
}
