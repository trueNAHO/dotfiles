lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "todo-comments" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.todo-comments.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/todo-comments
  ];
}
