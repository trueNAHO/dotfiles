{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.nix-alien.enable = true;
  imports = [../../../../modules/nix-alien];
  name = "nix-alien";
}
