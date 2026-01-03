{
  description = "LaTeX development environment for this resume template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        filename = "resume";
        pkgs = nixpkgs.legacyPackages.${system};
        tex = (pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic dvisvgm dvipng # for preview and export as html
            wrapfig amsmath ulem hyperref capt-of xelatex-dev titlesec
            fontawesome5 multirow enumitem plex-otf xkeyval unicode-math
            latexmk;
          #(setq org-latex-compiler "lualatex")
          #(setq org-preview-latex-default-process 'dvisvgm)
        });
        my-fonts = with pkgs; [ ibm-plex lato ];
        # Generate a font configuration file that includes these fonts
        fonts-conf = pkgs.makeFontsConf { fontDirectories = my-fonts; };
      in {
        packages.default = pkgs.stdenvNoCC.mkDerivation {
          name = "resume";
          src = self;
          phases = [ "unpackPhase" "buildPhase" "installPhase" ];
          env = { FONTCONFIG_FILE = "${fonts-conf}"; };
          buildInputs = [ tex ] ++ my-fonts;
          buildPhase = ''
            latexmk -pdf -xelatex ${filename}.tex
          '';
          installPhase = ''
            mkdir -p $out
            cp ${filename}.pdf $out/${filename}.pdf
          '';
        };
        devShells.default = pkgs.mkShell {
          shellHook = ''
            export FONTCONFIG_FILE=${fonts-conf}
          '';
          packages = [ tex ] ++ my-fonts;
        };
        apps.default = let
          myScriptPkg = pkgs.writeShellScriptBin "my-program" ''
            nix build
            cp ./result/${filename}.pdf ${filename}.pdf
            rm -rf ./result
          '';
        in {
          type = "app";
          name = "resume-tex-to-pdf";
          program = "${myScriptPkg}/bin/my-program";
        };
      });
}
