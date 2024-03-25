{
  inputs,
  pkgs,
  system,
}:
import ../lib/home_configurations/prependPrefix.nix {
  inherit inputs pkgs system;

  files = [./private];
  prefix = system;
}
