{
  config,
  pkgs,
  lib,
  ...
}:
let
  user = "ehpc";
  group = "yandexdisk";
  stateDirName = "yandex-disk";
  stateDir = "/var/lib/${stateDirName}";
  syncDir = "${stateDir}/sync";
  configDir = "${stateDir}/.config/yandex-disk";
in
{
  environment.systemPackages = with pkgs; [
    yandex-disk
    (writeShellScriptBin "yandex-disk-status" ''
      yandex-disk status -a ${stateDir}/token -d ${syncDir}
    '')
  ];

  users.groups.${group} = {
    members = [ "ehpc" ];
  };

  systemd.tmpfiles.rules = [
    "d ${syncDir} 0770 ${user} ${group} - -"
    "d ${configDir} 0770 ${user} ${group} - -"
  ];

  systemd.services.yandex-disk-ehpc = {
    description = "Yandex.Disk (ehpc)";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";
      User = user;
      Group = group;

      StateDirectory = "${stateDirName}";
      StateDirectoryMode = "0770";

      # IMPORTANT:
      # yandex-disk expects a token file. Generate it manually beforehand:
      # sudo systemd-run --pipe --wait \
      # --property=ProtectHome=true \
      # --property=User=ehpc \
      # --property=Environment="HOME=/var/lib/yandex-disk" \
      # -- yandex-disk token \
      #   /var/lib/yandex-disk/token
      ExecStart = ''
        ${pkgs.yandex-disk}/bin/yandex-disk start --no-daemon \
          -a ${stateDir}/token \
          -d ${syncDir}
      '';

      Restart = "on-failure";
      RestartSec = "3s";

      Environment="HOME=${stateDir}";
      NoNewPrivileges = true;
      PrivateTmp = true;
      PrivateDevices = true;
      ProtectSystem = "strict";
      ProtectHome = "tmpfs";
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      LockPersonality = true;
      RestrictRealtime = true;
      MemoryDenyWriteExecute = true;
      UMask = "0007";

      ReadWritePaths = [
        stateDir
        syncDir
      ];

      RestrictAddressFamilies = [
        "AF_UNIX"
        "AF_INET"
        "AF_INET6"
      ];

      CapabilityBoundingSet = "";
      AmbientCapabilities = "";
    };
  };
}
