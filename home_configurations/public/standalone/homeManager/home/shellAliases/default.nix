{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.shellAliases.enable = true;
  imports = [../../../../../../modules/homeManager/home/shellAliases];
  name = "shellAliases";
}
