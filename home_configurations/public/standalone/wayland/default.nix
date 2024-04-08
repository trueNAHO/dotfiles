{
  inputs,
  pkgs,
  system,
}:
import ../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.wayland.enable = true;
  imports = [../../../../modules/wayland];
  name = "wayland";
}
