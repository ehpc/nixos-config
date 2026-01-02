{ pkgs, isDarwin, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      vim

      wget
      curl

      unzip
      ripgrep

      net-tools
      dig
    ]
    ++ (
      if isDarwin then
        [ ]
      else
        [
          gparted
          lshw
          pciutils
          traceroute
        ]
    );
}
