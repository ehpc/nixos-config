{ pkgs, ... }:
{
  services.fluidsynth = {
    enable = true;
    soundService = "pipewire-pulse";
    soundFont = "${pkgs.soundfont-fluid}/share/soundfonts/FluidR3_GM2-2.sf2";
  };
}
