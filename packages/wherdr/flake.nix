{
  description = "Packaged Wherdr web client for Herdr";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      mkWherdr =
        pkgs:
        let
          version = "1.3.4";
          src = pkgs.fetchzip {
            url = "https://registry.npmjs.org/wherdr/-/wherdr-${version}.tgz";
            hash = "sha256-lkmefT5+ntb23FnZgGdwBz+KiCv6uZoqsgYJ1VgsGNk=";
          };
          qrcode-terminal = pkgs.fetchzip {
            url = "https://registry.npmjs.org/qrcode-terminal/-/qrcode-terminal-0.12.0.tgz";
            hash = "sha256-iZOIOrVi4U889g50PsY6Px+ymhF8GOxkQ8FG3Vrwww4=";
          };
        in
        pkgs.stdenvNoCC.mkDerivation {
          pname = "wherdr";
          inherit version src;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          installPhase = ''
            runHook preInstall
            mkdir -p "$out/lib/node_modules/wherdr/node_modules" "$out/bin"
            cp -R . "$out/lib/node_modules/wherdr"
            cp -R ${qrcode-terminal} "$out/lib/node_modules/wherdr/node_modules/qrcode-terminal"
            makeWrapper ${pkgs.nodejs_22}/bin/node "$out/bin/wherdr" \
              --add-flags "$out/lib/node_modules/wherdr/bin/wherdr.mjs"
            runHook postInstall
          '';

          meta = {
            description = "Web and mobile client for Herdr coding agents";
            homepage = "https://wherdr.dev";
            license = pkgs.lib.licenses.mit;
            mainProgram = "wherdr";
            platforms = systems;
          };
        };
    in
    {
      overlays.default = final: _prev: {
        wherdr = mkWherdr final;
      };
      packages = forAllSystems (system: {
        wherdr = mkWherdr nixpkgs.legacyPackages.${system};
        default = self.packages.${system}.wherdr;
      });
    };
}
