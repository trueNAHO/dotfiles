{
  inputs,
  pkgs,
  system,
}:
import ../../../lib/prependPrefix.nix {
  inherit inputs pkgs system;

  files = [./full];
  prefix = "integrated";
}
