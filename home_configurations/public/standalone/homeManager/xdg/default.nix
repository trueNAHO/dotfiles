{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.xdg.enable = true;
    imports = [../../../../../modules/homeManager/xdg];
  };

  name = "xdg";
}
