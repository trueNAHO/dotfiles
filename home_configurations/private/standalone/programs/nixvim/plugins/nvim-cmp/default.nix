lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "nvim-cmp" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.nvim-cmp.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/nvim-cmp
  ];
}
