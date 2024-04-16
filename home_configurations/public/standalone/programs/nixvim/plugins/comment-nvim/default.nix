lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "comment-nvim" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.comment-nvim.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/comment-nvim
  ];
}
