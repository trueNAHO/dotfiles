{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.agenix.homeManagerModules.default.enable = true;
    imports = [../../../../../../modules/agenix/homeManagerModules/default];
  };

  name = "default";
}
