{ pkgs, ... }:
{
  home.packages = [ pkgs.maestral-gui ];

  systemd.user.services.maestral = {
    Unit = {
      Description = "Maestral Dropbox GUI";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.maestral-gui}/bin/maestral_qt";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
