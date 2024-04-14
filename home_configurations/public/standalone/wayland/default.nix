{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.wayland.enable = true;
    imports = [../../../../modules/wayland];
  };

  name = "wayland";
}
