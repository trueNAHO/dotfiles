{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.programs.ripgrep.enable = true;
    imports = [../../../../../../modules/homeManager/programs/ripgrep];
  };

  name = "ripgrep";
}
