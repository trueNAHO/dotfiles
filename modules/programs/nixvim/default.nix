{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../homeManager/home/sessionVariables
    ./autoCmd
    ./keymaps
    ./opts
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.dotfiles.programs.nixvim = {
    enable = lib.mkEnableOption "dotfiles.programs.nixvim";
    full = lib.mkEnableOption "dotfiles.programs.nixvim.full";
  };

  config = let
    cfg = config.dotfiles.programs.nixvim;
  in
    lib.mkIf cfg.enable (lib.mkMerge [
      {
        dotfiles.homeManager.home.sessionVariables = {
          EDITOR.enable = true;
          MANPAGER.enable = true;
          enable = true;
        };

        home.shellAliases.n = lib.getExe config.programs.nixvim.finalPackage;

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

      (lib.mkIf cfg.full {
        dotfiles.programs.nixvim = {
          autoCmd.enable = lib.mkDefault true;
          keymaps.enable = lib.mkDefault true;
          opts.enable = lib.mkDefault true;
          plugins.full = lib.mkDefault true;
        };
      })
    ]);
}
