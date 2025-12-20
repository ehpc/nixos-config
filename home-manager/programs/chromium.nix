{ ... }:
{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--enable-features=Vulkan"
      "--enable-unsafe-webgpu"
    ];
  };
}
