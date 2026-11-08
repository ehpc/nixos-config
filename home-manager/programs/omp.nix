{
  lib,
  pkgs,
  pkgsUnstable,
  ...
}:
let
  settings = {
    modelRoles = {
      default = "openai-codex/gpt-6.1-sol";
      task = "openai-codex/gpt-6.1-terra:auto";
      slow = "openai-codex/gpt-6-astra:auto";
      plan = "openai-codex/gpt-6.1-sol:auto";
      image = "openai-codex/gpt-image-2";
      vision = "openai-codex/gpt-6.1-terra:auto";

      smol = "openai-codex/gpt-6-luna:low";
      tiny = "openai-codex/gpt-6-luna:low";
      commit = "openai-codex/gpt-6-luna:low";
      advisor = "openai-codex/gpt-6.1-sol:auto";
      judge = "openai-codex/gpt-6-luna:low";
    };

    find.enabled = "on";

    retry = {
      modelFallback = true;
      fallbackRevertPolicy = "cooldown-expiry";
      fallbackChains = {
        default = [
          "openrouter/z-ai/glm-5.3-flash:floor:low"
        ];
        slow = [
          "openrouter/z-ai/glm-5.3:floor:high"
          "openrouter/z-ai/glm-5.3-flash:floor:low"
        ];
        judge = [
          "openrouter/z-ai/glm-5.3-flash:floor:low"
        ];
        image = [ ];
      };
    };

    symbolPreset = "nerd";
    composer.shape = "band";
    theme.dark = "titanium";
    setupVersion = 2;
    defaultThinkingLevel = "auto";
  };
  configFile = (pkgs.formats.yaml { }).generate "omp-config.yml" settings;
in
{
  home.packages = [ pkgsUnstable.omp ];

  # omp rewrites this file when preferences change. Keep it writable, but
  # restore the declared settings on every Home Manager activation.
  home.activation.ompSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run mkdir -p "$HOME/.omp/agent"
    run install -m600 ${configFile} "$HOME/.omp/agent/config.yml"
  '';
}
