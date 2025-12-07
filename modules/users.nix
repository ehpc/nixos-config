{ pkgs, ... }:
{
  users.users.ehpc = {
    isNormalUser = true;
    description = "ehpc";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
    ];
  };
}
