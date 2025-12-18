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
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-vaapi-driver
    ];
  };

  environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  services.lact.enable = true;
}
