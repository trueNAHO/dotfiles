{pkgs, ...}: let
  leader = " ";
  neovim = pkgs.neovim.meta.mainProgram;
in {
  imports = [./maps ./options ./plugins];

  home = {
    sessionVariables.EDITOR = neovim;
    shellAliases.n = neovim;
  };

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = leader;
      maplocalleader = leader;
    };
  };
}
