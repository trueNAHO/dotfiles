{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.services.gpg-agent.enable = true;
  imports = [../../../../../../modules/homeManager/services/gpg-agent];
  name = "gpg-agent";
}
