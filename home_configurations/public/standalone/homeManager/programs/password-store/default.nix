{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.programs.password-store.enable = true;
  imports = [../../../../../../modules/homeManager/programs/password-store];
  name = "password-store";
}
