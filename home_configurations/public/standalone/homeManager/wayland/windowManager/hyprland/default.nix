{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.wayland.windowManager.hyprland.enable =
    true;

  imports = [
    ../../../../../../../modules/homeManager/wayland/windowManager/hyprland
  ];

  name = "hyprland";
}
