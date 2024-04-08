{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [
    ./fonts
    ./home
    ./nixpkgs
    ./programs
    ./services
    ./systemd
    ./wayland
    ./xdg
  ];

  prefix = "homeManager";
}
