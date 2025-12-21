{ pkgs, ... }:
let
  webcamZoom = "175";
  webcamOptions = "--set-ctrl=zoom_absolute=${webcamZoom}";
in
{
  services.udev = {
    enable = true;
    extraRules = ''
      # Zoom in Logitech C922 Pro camera
      SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="085c", RUN+="${pkgs.v4l-utils}/bin/v4l2-ctl -d $devnode ${webcamOptions}"
    '';
  };
}
