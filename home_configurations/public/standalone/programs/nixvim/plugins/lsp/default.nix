lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "lsp" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.lsp.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/lsp
  ];
}
