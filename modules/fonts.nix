{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-color-emoji
      nerd-fonts.noto
      nerd-fonts.liberation
      nerd-fonts.ubuntu
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.monaspace
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [
          "MonaspiceNe Nerd Font"
          "Monaspace"
        ];
        sansSerif = [
          "NotoSans Nerd Font"
          "Noto Sans"
        ];
        serif = [
          "NotoSerif Nerd Font"
          "Noto Serif"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
