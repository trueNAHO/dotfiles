{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.sessionVariables.enable = true;
  imports = [../../../../../../modules/homeManager/home/sessionVariables];
  name = "sessionVariables";
}
