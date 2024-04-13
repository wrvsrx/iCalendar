{
  description = "flake template";

  inputs = {
    flake-lock.url = "/home/wrvsrx/Documents/flake-lock";
    nixpkgs.follows = "flake-lock/nixpkgs";
    flake-parts.follows = "flake-lock/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { inputs, ... }:
      {
        systems = [ "x86_64-linux" ];
        perSystem =
          { pkgs, ... }:
          rec {
            packages.default = pkgs.haskellPackages.callPackage ./default.nix { };
            devShells.default = pkgs.mkShell {
              inputsFrom = [ packages.default.env ];
              nativeBuildInputs = [ pkgs.haskell-language-server ];
            };
            formatter = pkgs.nixfmt-rfc-style;
          };
      }
    );
}
