lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "treesitter" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.treesitter.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/treesitter
  ];
}
