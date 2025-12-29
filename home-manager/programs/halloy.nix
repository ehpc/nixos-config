{ config, ... }:
{
  programs.halloy = {
    enable = true;
    settings = {
      buffer = {
        channel = {
          topic = {
            enabled = true;
          };
        };
      };
      servers = {
        liberachat = {
          channels = [
            "#halloy"
          ];
          nickname = "ehpc";
          server = "irc.libera.chat";
          nick_password_file = config.sops.secrets."irc-pwd".path;
        };
      };
    };
  };
}
