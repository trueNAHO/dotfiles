{
  inputs,
  pkgs,
  system,
}: let
  name = "plugins";
in
  (import ../../../../../../lib/home_configurations/prependPrefix {
    inherit inputs pkgs system;

    files = [./codeium-nvim ./codeium-vim ./nvim-cmp];
    prefix = name;
  })
  // (import ../../../../../../lib/home_configurations/home_configuration {
    inherit inputs name pkgs system;

    homeManagerConfig.modules.programs.nixvim = {
      enable = true;
      plugins.full = true;
    };

    imports = [
      ../../../../../../modules/programs/nixvim
      ../../../../../../modules/programs/nixvim/plugins
    ];
  })
