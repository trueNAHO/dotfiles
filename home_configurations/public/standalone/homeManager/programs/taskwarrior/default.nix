{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.taskwarrior.enable = true;
  imports = [../../../../../../modules/homeManager/programs/taskwarrior];
  name = "taskwarrior";
}
