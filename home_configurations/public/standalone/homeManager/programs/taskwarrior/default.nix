lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "taskwarrior" {
  config.modules.homeManager.programs.taskwarrior.enable = true;
  imports = [../../../../../../modules/homeManager/programs/taskwarrior];
}
