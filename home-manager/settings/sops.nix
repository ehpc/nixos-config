{ username, ... }:
{
  sops = {
    defaultSopsFile = ../../secrets/${username}.yaml;
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };
    secrets = {
      hello = { };
      irc-pwd = { };
    };
  };
}
