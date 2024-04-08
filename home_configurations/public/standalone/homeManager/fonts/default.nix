{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.fonts.enable = true;
  imports = [../../../../../modules/homeManager/fonts];
  name = "fonts";
}
