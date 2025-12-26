{
  pkgs,
  pkgsUnstable,
  ...
}:
let
  reaperLatest = pkgsUnstable.reaper.overrideAttrs (old: rec {
    version = "7.57";
    src = pkgs.fetchurl {
      url = "https://www.reaper.fm/files/7.x/reaper757_linux_x86_64.tar.xz";
      hash = "sha256-XQm1x98dfWUsbd+9DRWTiIqL/yVewF9sfpSX3U8UXI8=";
    };
  });
in
{
  home.packages = [
    reaperLatest
  ];
}
