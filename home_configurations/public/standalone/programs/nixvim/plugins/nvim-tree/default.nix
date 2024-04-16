lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "nvim-tree" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.nvim-tree.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/nvim-tree
  ];
}
