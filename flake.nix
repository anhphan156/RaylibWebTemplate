{
  description = "Raylib Web Game Template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells."${system}".default = pkgs.mkShell {
      packages = with pkgs; [
        gcc
        raylib
        emscripten
      ];
      C_INCLUDE_PATH = "${pkgs.emscripten}/share/emscripten/cache/sysroot/include/";
    };
  };
}
