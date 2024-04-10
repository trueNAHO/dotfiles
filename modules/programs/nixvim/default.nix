{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../homeManager/home/sessionVariables
    ./autoCmd
    ./keymaps
    ./options
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.programs.nixvim = {
    enable = lib.mkEnableOption "modules.programs.nixvim";
    full = lib.mkEnableOption "modules.programs.nixvim.full";
  };

  config = lib.mkIf config.modules.programs.nixvim.enable (lib.mkMerge [
    {
      modules.homeManager.home.sessionVariables = {
        EDITOR.enable = true;
        MANPAGER.enable = true;
      };

      home.shellAliases.n = pkgs.neovim.meta.mainProgram;

      programs.nixvim = {
        enable = true;

        globals = let
          leader = " ";
        in {
          mapleader = leader;
          maplocalleader = leader;
        };
      };
    }

    (lib.mkIf config.modules.programs.nixvim.full {
      modules.programs.nixvim = {
        autoCmd.enable = lib.mkDefault true;
        keymaps.enable = lib.mkDefault true;
        options.enable = lib.mkDefault true;
        plugins.full = lib.mkDefault true;
      };
    })
  ]);
}
