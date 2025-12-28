{ ... }:
{
  security = {
    sudo = {
      extraConfig = ''
        Defaults timestamp_timeout=30
      '';
    };
    rtkit.enable = true;
    polkit.enable = true;
  };
}
