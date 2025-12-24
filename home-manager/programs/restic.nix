{ pkgs, ... }:
let
  essentialPaths = [
    "/home/ehpc/dropbox"
  ];
  essentialPasswordFile = "/home/ehpc/.config/restic/password";
  essentialRepoYandexDisk = "/home/ehpc/yandex-disk/backups/essential";
  essentialRepoLocal = "/home/ehpc/safestorage/backups/essential";
  pruneOpts = [
    "--keep-daily=7"
    "--keep-weekly=5"
    "--keep-monthly=12"
  ];
in
{
  services.restic = {
    enable = true;
    backups = {
      essential-local = {
        repository = essentialRepoLocal;
        paths = essentialPaths;
        passwordFile = essentialPasswordFile;
        initialize = true;
        pruneOpts = pruneOpts;
        timerConfig = {
          OnCalendar = "20:00";
          Persistent = true;
          RandomizedDelaySec = "5m";
        };
      };
      essential-yandex-disk = {
        repository = essentialRepoYandexDisk;
        paths = essentialPaths;
        passwordFile = essentialPasswordFile;
        initialize = true;
        pruneOpts = pruneOpts;
        timerConfig = {
          OnCalendar = "20:10";
          Persistent = true;
          RandomizedDelaySec = "5m";
        };
      };
    };
  };
}
