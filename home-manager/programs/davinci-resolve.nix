{ pkgsUnstable, lib, ... }:
let
  davinci-resolve-studio = pkgsUnstable.writeShellScriptBin "davinci-resolve-studio" ''
    ROC_ENABLE_PRE_VEGA=1 RUSTICL_ENABLE=amdgpu,amdgpu-pro,radv,radeon QT_QPA_PLATFORM=xcb ${lib.getExe pkgsUnstable.davinci-resolve-studio}
  '';
in
{
  home.packages = [
    davinci-resolve-studio
  ];
}
