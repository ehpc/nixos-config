{
  self,
  nixpkgs,
  system,
  ...
}:
{
  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 6;

  nixpkgs.hostPlatform = "aarch64-darwin";

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    primaryUser = "ehpc";
    defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      finder.AppleShowAllExtensions = true;
      finder.FXPreferredViewStyle = "clmv";
      loginwindow.LoginwindowText = "hello :)";
      screencapture.location = "~/Pictures/screenshots";
      controlcenter.NowPlaying = true;
    };
  };

  imports = [
    ./system-packages.nix
    ./users.nix
  ];
}
