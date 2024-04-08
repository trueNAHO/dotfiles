{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.qutebrowser.enable = true;
  imports = [../../../../../../modules/homeManager/programs/qutebrowser];
  name = "qutebrowser";
}
