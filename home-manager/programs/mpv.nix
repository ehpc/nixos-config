{ ... }:
{
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "high-quality" ];
    config = {
      vo = "gpu-next";
      gpu-api = "vulkan";
      gpu-context = "waylandvk";
      ytdl-format = "bestvideo+bestaudio";
      alang = "ja,jpn,zh,zho,fr,fra,en,eng";
      slang = "fr,fra,ru,rus,en,eng";
      save-position-on-quit = "yes";
      hwdec = "auto";
      volume-max = 200;
    };
  };
}
