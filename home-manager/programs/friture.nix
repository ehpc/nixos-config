{ pkgsUnstable, lib, ... }:

{
  home.packages = [
    pkgsUnstable.friture
  ];

  xdg.desktopEntries.friture = {
    name = "Friture";
    exec = "env QT_QPA_PLATFORM=xcb ${lib.getExe pkgsUnstable.friture}";
    icon = "friture";
    terminal = false;
    categories = [
      "AudioVideo"
      "Audio"
    ];
  };
}
