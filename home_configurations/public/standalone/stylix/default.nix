{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.stylix.enable = true;
    imports = [../../../../modules/stylix];
  };

  name = "stylix";
}
