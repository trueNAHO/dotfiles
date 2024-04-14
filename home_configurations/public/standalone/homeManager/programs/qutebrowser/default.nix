{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.programs.qutebrowser.enable = true;
    imports = [../../../../../../modules/homeManager/programs/qutebrowser];
  };

  name = "qutebrowser";
}
