{ ... }:
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
        };
      };
    };
  };
}
