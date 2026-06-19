{ config, pkgs, ... }:
{
  programs.distrobox = {
    enable = true;
    containers = {
      davincibox = {
        image = "ghcr.io/zelikos/davincibox-opencl:latest";
      };
    };
  };
}
