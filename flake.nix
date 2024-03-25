{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    eachSystem allSystems (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.myProgram = pkgs.stdEnv.mkDerivation {
          name = "basic-flake";
          src = self;
        };
        packages.default = packages.myProgram;

        formatter = pkgs.writeShellScriptBin "format.sh" ''
          ${pkgs.nixfmt}/bin/nixfmt *.nix
        '';

      });
}
