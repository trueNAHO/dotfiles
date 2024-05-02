lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "comment" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.comment.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/comment
  ];
}
