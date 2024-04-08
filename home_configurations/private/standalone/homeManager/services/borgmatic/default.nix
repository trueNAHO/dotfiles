{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.services.borgmatic.enable = true;
  imports = [../../../../../../modules/homeManager/services/borgmatic];
  name = "borgmatic";
}
