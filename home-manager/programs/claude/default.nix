{
  pkgs,
  pkgsUnstable,
  username,
  ...
}:
{
  home.file.".claude/statusline-command.sh" = {
    source = ./statusline-command.sh;
    executable = true;
  };

  home.file.".claude/skills/playwright-cli" = {
    source = pkgs.playwright-cli.src + "/skills/playwright-cli";
    recursive = true;
  };

  programs.claude-code = {
    enable = true;
    package = pkgsUnstable.claude-code;
    skills = { };
    settings = {
      env = {
        CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1";
        ENABLE_LSP_TOOL = "1";
      };
      preferences = {
        tmuxSplitPanes = true;
      };
      includeCoAuthoredBy = false;
      permissions = {
        additionalDirectories = [
        ];
        allow = [
          "Skill"
          "Read"
          "Grep"
          "Glob"
          "LS"
          "WebFetch"
          "WebSearch"
          "Bash(git status)"
          "Bash(git log *)"
          "Bash(git diff *)"
          "Bash(git show *)"
          "Bash(git branch *)"
          "Bash(git commit *)"
          "Bash(ls *)"
          "Bash(cat *)"
          "Bash(echo *)"
          "Bash(which *)"
          "Bash(pwd)"
          "Bash(env *)"
          "Bash(printenv *)"
          "Bash(find *)"
          "Bash(wc *)"
          "Bash(head *)"
          "Bash(tail *)"
          "Bash(sort *)"
          "Bash(uniq *)"
          "Bash(grep *)"
          "Bash(tree *)"
          "Bash(file *)"
          "Bash(rg *)"
          "Bash(fd *)"
          "Bash(jq *)"
        ];
        ask = [
        ];
        defaultMode = "acceptEdits";
        deny = [
          "Bash(sudo *)"
          "Bash(rm *)"
          "Bash(rm -rf *)"
          "Bash(git push *)"
          "Bash(git reset *)"
          "Bash(git rebase *)"
          "Read(.env)"
          "Read(.env.*)"
          "Read(id_rsa)"
          "Read(id_ed25519)"
        ];
      };
      statusLine = {
        command = "bash /home/${username}/.claude/statusline-command.sh";
        type = "command";
      };
      theme = "dark";
      sandbox = {
        enabled = true;
        failIfUnavailable = false;
        filesystem = {
          allowWrite = [
            "./"
            "~/.cache/"
          ];
          denyWrite = [
            "~/.ssh"
            "~/.gnupg"
          ];
        };
      };
    };
  };
}
