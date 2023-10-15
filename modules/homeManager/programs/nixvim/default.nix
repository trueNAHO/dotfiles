{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./maps
    ./options
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.homeManager.programs.nixvim.enable =
    lib.mkEnableOption "nixvim";

  config = lib.mkIf config.modules.homeManager.programs.nixvim.enable {
    home = let
      neovim = pkgs.neovim.meta.mainProgram;
    in {
      sessionVariables.EDITOR = neovim;
      shellAliases.n = neovim;
    };

    programs.nixvim = {
      enable = true;

      globals = let
        leader = " ";
      in {
        mapleader = leader;
        maplocalleader = leader;
      };
    };
  };
}
