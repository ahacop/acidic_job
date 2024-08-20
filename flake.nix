{
  description = "A Nix-flake-based Ruby development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-ruby,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            nixpkgs-ruby.overlays.default
          ];
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            curl
            docker
            docker-compose
            gmp
            gnumake
            libpcap
            libxml2
            libxslt
            libyaml
            openssl
            pkg-config
            postgresql_16
            protobuf
            readline
            sqlite
            pkgs."ruby-3.3.5"
          ];
        };
      }
    );
}
