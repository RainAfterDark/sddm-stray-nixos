
{
  description = "Your system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        sddm-stray = pkgs.callPackage ./nix {
          inherit (pkgs) lib stdenvNoCC fetchFromGitHub formats;
          kdePackages = pkgs.kdePackages;
         };

      in {
        packages.default = sddm-stray;
      });
}
