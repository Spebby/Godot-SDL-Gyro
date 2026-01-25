{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # Cross compilation for Windows x86_64
      pkgsWin = import nixpkgs {
        inherit system;
        crossSystem = {
          system = "x86_64-w64-mingw32";
        };
      };
    in
    {
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            scons
            pkg-config
            SDL2
            gcc
            binutils
          ];
        };
      };
    };
}
