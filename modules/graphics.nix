{ pkgs, ... }:
{
  hardware.amdgpu = {
    initrd.enable = false;
    opencl.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libvdpau
      libva-vdpau-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      vulkan-loader
      libva
      libvdpau
      libva-vdpau-driver
    ];
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    GBM_BACKEND = "radeonsi";
    WLR_RENDERER = "vulkan";
    VDPAU_DRIVER = "radeonsi";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  services.lact.enable = true;
}
