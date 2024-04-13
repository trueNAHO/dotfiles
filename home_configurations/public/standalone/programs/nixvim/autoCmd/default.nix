{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.programs.nixvim = {
    autoCmd.enable = true;
    enable = true;
  };

  imports = [
    ../../../../../../modules/programs/nixvim
    ../../../../../../modules/programs/nixvim/autoCmd
  ];

  name = "autoCmd";
}