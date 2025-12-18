{ username, email, ... }:
{
  programs.git = {
    enable = true;
    includes = [
      {
        contents = {
          user = {
            name = username;
            email = email;
          };
          init = {
            defaultBranch = "main";
          };
        };
      }
    ];
  };
}
