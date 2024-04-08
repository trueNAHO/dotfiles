{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../../lib/home_configurations/home_configuration {
  inherit inputs pkgs system;

  homeManagerConfig.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    true;

  imports = [
    ../../../../../../../modules/homeManager/nixpkgs/config/allowUnfree
  ];

  name = "allowUnfree";
}
