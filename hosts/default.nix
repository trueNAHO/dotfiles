{inputs, ...}:
inputs.flakeUtils.lib.eachDefaultSystem (
  system: let
    pkgs = inputs.nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations = import ./eachDefaultSystem.nix {inherit inputs pkgs;};
  }
)
