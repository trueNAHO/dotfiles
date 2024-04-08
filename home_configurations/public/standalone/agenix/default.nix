{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [./homeManagerModules];
  prefix = "agenix";
}
