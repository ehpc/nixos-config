{
  config,
  pkgs,
  pkgsUnstable,
  lib,
  ...
}:
let
  wherdr = pkgs.wherdr;
  herdr = pkgsUnstable.herdr;
  plugin = pkgs.writeTextDir "herdr-plugin.toml" ''
    id = "afloury.wherdr"
    name = "wherdr"
    version = "${wherdr.version}"
    min_herdr_version = "0.9.1"
    description = "Your Herdr agents from your phone and browser."
    platforms = ["linux"]

    [[actions]]
    id = "panel"
    title = "wherdr"
    contexts = ["global", "workspace"]
    command = ["${lib.getExe herdr}", "plugin", "pane", "open", "--plugin", "afloury.wherdr", "--entrypoint", "panel", "--focus"]

    [[actions]]
    id = "open"
    title = "wherdr: open in the browser"
    contexts = ["global", "workspace"]
    command = ["${lib.getExe wherdr}", "open"]

    [[panes]]
    id = "panel"
    title = "wherdr"
    placement = "popup"
    width = "80%"
    height = "90%"
    command = ["${lib.getExe wherdr}", "panel"]
  '';
in
{
  home.packages = [ wherdr ];

  # Herdr keeps its plugin registry as runtime state. Linking the immutable
  # manifest on every activation makes that state converge without downloads.
  home.activation.wherdrPlugin = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${lib.getExe herdr} plugin unlink afloury.wherdr || true
    run ${lib.getExe herdr} plugin link ${plugin}
  '';

  systemd.user.services.herdr = {
    Unit = {
      Description = "Herdr headless terminal workspace server";
    };
    Service = {
      Type = "exec";
      # Do not stop or compete with an existing manually started session.
      ExecCondition = pkgs.writeShellScript "herdr-needs-server" ''
        ! ${lib.getExe herdr} status server --json | ${lib.getExe pkgs.jq} -e '.running' > /dev/null
      '';
      ExecStart = "${lib.getExe herdr} server";
      WorkingDirectory = "%h";
      Environment = [
        "PATH=%h/.local/bin:%h/bin:%h/.nix-profile/bin:/etc/profiles/per-user/${config.home.username}/bin:/run/wrappers/bin:/run/current-system/sw/bin"
      ];
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.services.wherdr = {
    Unit = {
      Description = "Wherdr web client for Herdr";
      After = [
        "network.target"
        "herdr.service"
      ];
      Wants = [ "herdr.service" ];
    };
    Service = {
      ExecStart = "${lib.getExe wherdr} run --host 127.0.0.1 --port 7683 --data-dir %h/.local/share/wherdr";
      Restart = "on-failure";
      RestartSec = 5;
      Environment = [
        "HERDR_BIN=${lib.getExe herdr}"
        "PATH=${
          lib.makeBinPath [
            herdr
            pkgs.git
            pkgs.openssh
            pkgs.tailscale
            pkgs.xdg-utils
          ]
        }"
      ];
    };
    Install.WantedBy = [ "default.target" ];
  };
}
