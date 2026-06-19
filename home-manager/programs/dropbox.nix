{ username, ... }:
{
  services.dropbox = {
    enable = true;
    path = "/home/${username}/dropbox";
  };
}
