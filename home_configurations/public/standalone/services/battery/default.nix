{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.services.battery.enable = true;
    imports = [../../../../../modules/services/battery];
  };

  name = "battery";
}
