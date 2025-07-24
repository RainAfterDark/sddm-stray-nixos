{
  description = "Modded SDDM Stray Flake for NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        sddm-stray-nixos = pkgs.callPackage ./nix {
          inherit (pkgs)
            lib
            stdenvNoCC
            ;
          kdePackages = pkgs.kdePackages;
        };

      in
      {
        packages.default = sddm-stray-nixos;
      }
    );
}
