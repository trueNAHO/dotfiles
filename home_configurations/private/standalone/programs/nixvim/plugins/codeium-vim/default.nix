lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "codeium-vim" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.codeium-vim.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/codeium-vim
  ];
}
