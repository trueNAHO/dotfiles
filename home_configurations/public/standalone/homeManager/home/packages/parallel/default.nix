{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.packages.parallel.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/parallel];
  name = "parallel";
}