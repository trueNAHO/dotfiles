{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.xdg.enable = true;
  imports = [../../../../../modules/homeManager/xdg];
  name = "xdg";
}
