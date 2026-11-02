{
  description = "LaTeX resume dev shell with pinned nixpkgs-unstable";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      let
        # Default LaTeX source path. Override by passing an argument, e.g.:
        #   render ./other.tex
        default-src = "resume/main.tex";

        tex-env = pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-medium
            preprint
            fontawesome5
            titlesec
            marvosym
            enumitem
            fancyhdr
            hyperref
            babel
            tools
            roboto
            fontaxes
            ;
        };

        resume-scripts = with pkgs; [
          (writeShellScriptBin "render" ''
            exec latexmk -pdf main.tex "$@"
          '')
          (writeShellScriptBin "watch" ''
            exec latexmk -pdf -pvc main.tex "$@"
          '')
          (writeShellScriptBin "clean" ''
            exec latexmk -C "$@"
          '')
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          name = "resume-cv";

          buildInputs = [
            # Custom texlive env: scheme-medium plus packages the resume
            # template needs that are not in scheme-medium (fullpage,
            # fontawesome5). latexmk is included with the scheme.
            tex-env
          ] ++ resume-scripts;
        };
      });
}
