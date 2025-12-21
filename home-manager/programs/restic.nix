{ ... }:
{
  # services.restic = {
  #   enable = true;
  #   repositories = {
  #     essential = {
  #       path = "/path/to/backup";
  #       passwordFile = "/home/ehpc/.restic-password";
  #       retentionPolicy = {
  #         keepLast = 7;
  #         keepDaily = 30;
  #         keepWeekly = 8;
  #         keepMonthly = 6;
  #         keepYearly = 1;
  #       };
  #       schedule = "0 20 * * *";
  #     };
  #   };
  # };
}
