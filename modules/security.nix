{ ... }:
{
  security = {
    sudo = {
      extraConfig = ''
        Defaults timestamp_timeout=30
        # Share only this command's longer cache across desktop/phone terminals.
        Cmnd_Alias WHERDR_REBUILD = /run/current-system/sw/bin/nixos-rebuild switch --flake path\:/home/ehpc/nixos-config\#ehpc-desktop
        Defaults!WHERDR_REBUILD timestamp_type=global, timestamp_timeout=1440
      '';
    };
    rtkit.enable = true;
    polkit.enable = true;
  };
}
