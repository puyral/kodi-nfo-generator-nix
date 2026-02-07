{
  description = "Simple Python-based command-line tool to generate .nfo files for movies and TV shows for Kodi.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python3Packages;
      in
      {
        packages.default = pythonPackages.buildPythonApplication {
          pname = "kodi-nfo-generator";
          version = "0.0.19";

          src = ./.;

          pyproject = true;
          build-system = [
            pythonPackages.setuptools
          ];

          propagatedBuildInputs = with pythonPackages; [
            requests
            beautifulsoup4
          ];

          doCheck = false;

          meta = with pkgs.lib; {
            description = "Simple Python-based command-line tool to generate .nfo files for movies and TV shows for Kodi.";
            homepage = "https://github.com/fracpete/kodi-nfo-generator";
            license = licenses.gpl3;
            mainProgram = "kodi-nfo-gen";
          };
        };
      }
    );
}
