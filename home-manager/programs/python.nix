{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  home.packages = with pkgs; [
    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        pip
        setuptools
        wheel
        virtualenv

        numpy
        pandas
        matplotlib
        scipy
        statsmodels
      ]
    ))

    pkgsUnstable.ty
  ];
  programs = {
    uv = {
      enable = true;
      settings = {
        python-downloads = "never";
        python-preference = "only-system";
      };
    };
    ruff = {
      enable = true;
      settings = {
        target-version = "py313";

        line-length = 88;

        format = {
          quote-style = "double";
          indent-style = "space";
          line-ending = "lf";
        };

        lint = {
          select = [
            "E" # pycodestyle errors
            "W" # pycodestyle warnings
            "F" # pyflakes
            "I" # isort
            "B" # flake8-bugbear
            "C4" # flake8-comprehensions
            "UP" # pyupgrade
            "SIM" # flake8-simplify
            "RUF" # ruff-specific
            "PTH" # pathlib over os.path
            "TID" # tidy imports
          ];
        };
      };
    };
  };
}
