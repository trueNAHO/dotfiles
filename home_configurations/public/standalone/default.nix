{
  inputs,
  pkgs,
  system,
}:
import ../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [
    ./agenix
    ./homeManager
    ./nix-alien
    ./programs
    ./services
    ./stylix
    ./wayland
  ];

  prefix = "standalone";
}
