{ username, isDarwin, ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "high-quality" ];
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = if isDarwin then "macvk" else "waylandvk";
      ytdl-format = "bestvideo+bestaudio";
      alang = "ja,jpn,zh,zho,fr,fra,en,eng";
      slang = "fr,fra,ru,rus,en,eng";
      save-position-on-quit = "yes";
      hwdec = "auto";
      volume-max = 200;
      keep-open = "yes";
      screenshot-dir =
        if isDarwin then "/Users/${username}/screenshots/mpv" else "/home/${username}/screenshots/mpv";
      screenshot-template = "mpv-shot-%F-%p-%n";
    };
  };
}
