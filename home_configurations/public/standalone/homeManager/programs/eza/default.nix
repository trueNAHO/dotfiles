{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.eza.enable = true;
  imports = [../../../../../../modules/homeManager/programs/eza];
  name = "eza";
}
