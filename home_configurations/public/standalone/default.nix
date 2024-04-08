{
  inputs,
  pkgs,
  system,
}:
import ../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [./agenix ./homeManager ./nix-alien ./services ./stylix ./wayland];
  prefix = "standalone";
}
