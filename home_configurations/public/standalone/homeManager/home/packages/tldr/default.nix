{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.home.packages.tldr.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/tldr];
  name = "tldr";
}
