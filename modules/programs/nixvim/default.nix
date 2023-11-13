{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../stylix
    ./autoCmd
    ./colorschemes
    ./keymaps
    ./options
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.programs.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.modules.programs.nixvim.enable {
    modules.stylix.enable = true;

    home = let
      neovim = pkgs.neovim.meta.mainProgram;
    in {
      packages = with pkgs; [cargo rustc];
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
