{
  inputs,
  pkgs,
  system,
}: let
  name = "nixvim";
in
  (import ../../../../../lib/home_configurations/prependPrefix {
    inherit inputs pkgs system;

    files = [./plugins];
    prefix = name;
  })
  // (import ../../../../../lib/home_configurations/home_configuration {
    inherit inputs name pkgs system;

    homeManagerConfiguration = {
      config.modules.programs.nixvim.enable = true;
      imports = [../../../../../modules/programs/nixvim];
    };
  })
