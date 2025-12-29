{ pkgs, ... }:
let
  theme = "catppuccin-mocha";
  themeFile = "${theme}.theme";
in
{
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = true;
      cudaSupport = true;
    };
    settings = {
      color_theme = "catppuccin-mocha";
      shown_boxes = "cpu gpu0 mem net proc";
      proc_aggregate = true;
      custom_gpu_name0 = "Radeon RX 6600 Fighter 8GB";
    };
    themes = {
      catppuccin-mocha = builtins.readFile ./${themeFile};
    };
  };
}
