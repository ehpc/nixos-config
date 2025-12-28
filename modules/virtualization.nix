{ ... }:
{
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd.enable = true;

    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;
}
