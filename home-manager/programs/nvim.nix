{ ... }:
{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
    '';
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
