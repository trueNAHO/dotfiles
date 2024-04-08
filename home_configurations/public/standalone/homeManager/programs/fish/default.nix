{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.fish.enable = true;
  imports = [../../../../../../modules/homeManager/programs/fish];
  name = "fish";
}
