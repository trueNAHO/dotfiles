{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.services.easyeffects.enable = true;
    imports = [../../../../../../modules/homeManager/services/easyeffects];
  };

  name = "easyeffects";
}
