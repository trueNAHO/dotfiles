{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.home.packages.fd.enable = true;
    imports = [../../../../../../../modules/homeManager/home/packages/fd];
  };

  name = "fd";
}
