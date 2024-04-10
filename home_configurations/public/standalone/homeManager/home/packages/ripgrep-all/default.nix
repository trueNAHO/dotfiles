{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.packages.ripgrep-all.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/ripgrep-all];
  name = "ripgrep-all";
}