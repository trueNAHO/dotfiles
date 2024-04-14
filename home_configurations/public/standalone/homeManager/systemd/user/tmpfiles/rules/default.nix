{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.homeManager.systemd.user.tmpfiles.rules.enable = true;

    imports = [
      ../../../../../../../../modules/homeManager/systemd/user/tmpfiles/rules
    ];
  };

  name = "rules";
}
