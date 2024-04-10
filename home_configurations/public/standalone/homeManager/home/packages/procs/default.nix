{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.packages.procs.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/procs];
  name = "procs";
}