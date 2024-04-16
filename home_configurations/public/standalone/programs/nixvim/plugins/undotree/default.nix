lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "undotree" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.undotree.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/undotree
  ];
}
