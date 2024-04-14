{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfiguration = {
    config.modules.programs.nixvim = {
      enable = true;
      plugins.rustaceanvim.enable = true;
    };

    imports = [
      ../../../../../../../modules/programs/nixvim
      ../../../../../../../modules/programs/nixvim/plugins/rustaceanvim
    ];
  };

  name = "rustaceanvim";
}
