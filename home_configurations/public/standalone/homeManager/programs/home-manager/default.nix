{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.programs.home-manager.enable = true;
    imports = [../../../../../../modules/homeManager/programs/home-manager];
  };

  name = "home-manager";
}
