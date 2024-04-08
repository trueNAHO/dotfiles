{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.services.gammastep.enable = true;
  imports = [../../../../../../modules/homeManager/services/gammastep];
  name = "gammastep";
}
