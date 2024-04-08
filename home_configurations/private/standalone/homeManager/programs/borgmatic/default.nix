{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.borgmatic.enable = true;
  imports = [../../../../../../modules/homeManager/programs/borgmatic];
  name = "borgmatic";
}
