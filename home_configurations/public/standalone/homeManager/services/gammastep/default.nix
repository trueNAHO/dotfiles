{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.services.gammastep.enable = true;
    imports = [../../../../../../modules/homeManager/services/gammastep];
  };

  name = "gammastep";
}
