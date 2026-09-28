{ pkgs, lib, ... }:
let
  # Standalone Arturia instruments installed by the Arturia Software Center.
  apps = [
    "Analog Lab V"
    "Mini V4"
    "Piano V3"
    "Augmented STRINGS"
  ];

  # MIDI input is not user activity as far as macOS is concerned, so playing the
  # keyboard never resets the idle timer and the displays sleep mid-session.
  # Hold a PreventUserIdleDisplaySleep assertion for as long as an instrument runs.
  watcher = pkgs.writeShellScript "arturia-keep-display-awake" ''
    patterns=(${
      lib.escapeShellArgs (map (app: "/Applications/Arturia/${app}.app/Contents/MacOS/${app}") apps)
    })

    while :; do
      pid=""
      for pattern in "''${patterns[@]}"; do
        pid=$(/usr/bin/pgrep -f "$pattern" | head -n 1)
        [ -n "$pid" ] && break
      done

      # caffeinate -w blocks until that instrument quits.
      [ -n "$pid" ] && /usr/bin/caffeinate -d -w "$pid"

      sleep 20
    done
  '';
in
{
  launchd.agents.arturia-keep-display-awake = {
    enable = true;
    config = {
      ProgramArguments = [ "${watcher}" ];
      RunAtLoad = true;
      KeepAlive = true;
      ProcessType = "Background";
      StandardOutPath = "/dev/null";
      StandardErrorPath = "/dev/null";
    };
  };
}
