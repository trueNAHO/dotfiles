{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.imv.enable = true;
  imports = [../../../../../../modules/homeManager/programs/imv];
  name = "imv";
}
