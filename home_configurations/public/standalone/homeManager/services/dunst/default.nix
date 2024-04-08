{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.services.dunst.enable = true;
  imports = [../../../../../../modules/homeManager/services/dunst];
  name = "dunst";
}
