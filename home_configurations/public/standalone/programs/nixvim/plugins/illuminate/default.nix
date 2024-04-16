lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "illuminate" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.illuminate.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/illuminate
  ];
}
