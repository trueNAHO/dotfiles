lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "lsp-format" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.lsp-format.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/lsp-format
  ];
}
