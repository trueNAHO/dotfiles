{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.programs.mpv.enable = true;
    imports = [../../../../../../modules/homeManager/programs/mpv];
  };

  name = "mpv";
}
