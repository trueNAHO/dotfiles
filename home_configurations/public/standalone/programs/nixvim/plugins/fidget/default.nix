{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.programs.nixvim = {
    enable = true;
    plugins.fidget.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/fidget
  ];

  name = "fidget";
}