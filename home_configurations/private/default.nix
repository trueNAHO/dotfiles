{
  inputs,
  pkgs,
  system,
}:
import ../../lib/prependPrefix.nix {
  inherit inputs pkgs system;

  files = [./integrated];
  prefix = "private";
}
