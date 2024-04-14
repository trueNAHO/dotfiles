{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.services.swayidle.enable = true;
    imports = [../../../../../../modules/homeManager/services/swayidle];
  };

  name = "swayidle";
}
