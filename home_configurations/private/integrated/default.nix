{
  inputs,
  pkgs,
  system,
}:
import ../../../lib/home_configurations/prependPrefix.nix {
  inherit inputs pkgs system;

  files = [./full];
  prefix = "integrated";
}
