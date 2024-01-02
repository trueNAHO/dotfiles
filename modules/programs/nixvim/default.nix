{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../agenix/homeManagerModules/default
    ../../homeManager/home/packages/rustup
    ../../homeManager/nixpkgs/config/allowUnfree
    ../../homeManager/programs/man
    ./autoCmd
    ./keymaps
    ./options
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.programs.nixvim.enable = lib.mkEnableOption "nixvim";

  config = lib.mkIf config.modules.programs.nixvim.enable {
    modules = {
      agenix.homeManagerModules.default.enable = true;

      homeManager = {
        home.packages.rustup.enable = true;
        nixpkgs.config.allowUnfree.enable = true;
        programs.man.enable = true;
      };
    };

    age.secrets.modulesProgramsNixvimPluginsCodeium.file = plugins/codeium.age;

    home = let
      neovim = pkgs.neovim.meta.mainProgram;
    in {
      sessionVariables = {
        EDITOR = neovim;
        MANPAGER = "${neovim} +Man!";
      };

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
