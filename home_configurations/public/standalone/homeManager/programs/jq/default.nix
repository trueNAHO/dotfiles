{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.programs.jq.enable = true;
    imports = [../../../../../../modules/homeManager/programs/jq];
  };

  name = "jq";
}
