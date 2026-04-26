{
  description = "audio-separator CLI for Nix/NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      mkAudioSeparator =
        pkgs:
        let
          py = pkgs.python3;
          pp = py.pkgs;

          diffq = pp.buildPythonPackage rec {
            pname = "diffq";
            version = "0.2.4";
            format = "setuptools";

            src = pp.fetchPypi {
              inherit pname version;
              hash = "sha256-BJBkhh6XTr8A0LrauLMkx3UDc3FBntoxUJhbnUd7W9I=";
            };

            nativeBuildInputs = [ pp.cython ];
            propagatedBuildInputs = [
              pp.numpy
              pp.torch
            ];

            doCheck = false;
            pythonImportsCheck = [ "diffq" ];
          };

          onnx2torch-py313 = pp.buildPythonPackage rec {
            pname = "onnx2torch-py313";
            version = "1.6.0";
            pyproject = true;

            src = pp.fetchPypi {
              pname = "onnx2torch_py313";
              inherit version;
              hash = "sha256-0ntUx+Fw8SrSUv4Ybmyrjzyt6O5OWWaCrMWjr92tt1M=";
            };

            postPatch = ''
              substituteInPlace pyproject.toml \
                --replace-fail "onnx-weekly" "onnx"
            '';

            build-system = [ pp.setuptools ];

            propagatedBuildInputs = [
              pp.numpy
              pp.onnx
              pp.torch
              pp.torchvision
            ];

            doCheck = false;
            pythonImportsCheck = [ "onnx2torch" ];
          };

          audio-separator = pp.buildPythonApplication rec {
            pname = "audio-separator";
            version = "0.44.1";
            pyproject = true;

            src = pp.fetchPypi {
              pname = "audio_separator";
              inherit version;
              hash = "sha256-UFx4wgXOLmryen5zwbSlmwzHyDSiq92Ts/XNr488sm8=";
            };

            postPatch = ''
              substituteInPlace pyproject.toml \
                --replace-fail "onnx-weekly" "onnx"
            '';

            build-system = [ pp.poetry-core ];

            pythonRelaxDeps = [
              "samplerate"
              "beartype"
              "rotary-embedding-torch"
              "torch"
              "scipy"
              "numpy"
            ];

            dependencies =
              with pp;
              [
                requests
                numpy
                librosa
                samplerate
                six
                torch
                tqdm
                pydub
                onnx
                onnxruntime
                julius
                einops
                pyyaml
                ml-collections
                resampy
                beartype
                rotary-embedding-torch
                scipy
                soundfile
                diffq
                onnx2torch-py313
              ]
              ++ pkgs.lib.optionals (py.pythonAtLeast "3.13") [ pp.audioop-lts ];

            nativeBuildInputs = [ pkgs.makeWrapper ];

            doCheck = false;
            pythonImportsCheck = [ "audio_separator" ];

            postFixup = ''
              for bin in $out/bin/audio-separator $out/bin/audio-separator-remote; do
                if [ -e "$bin" ]; then
                  wrapProgram "$bin" \
                    --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.ffmpeg ]}
                fi
              done
            '';

            meta = with pkgs.lib; {
              description = "Easy to use audio stem separation, using various models from UVR";
              homepage = "https://github.com/nomadkaraoke/python-audio-separator";
              license = licenses.mit;
              mainProgram = "audio-separator";
            };
          };
        in
        audio-separator;
    in
    {
      overlays.default = final: prev: {
        audio-separator = mkAudioSeparator final;
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.audio-separator = mkAudioSeparator pkgs;
        packages.default = self.packages.${system}.audio-separator;

        apps.default = flake-utils.lib.mkApp {
          drv = self.packages.${system}.audio-separator;
          exePath = "/bin/audio-separator";
        };
      }
    );
}
