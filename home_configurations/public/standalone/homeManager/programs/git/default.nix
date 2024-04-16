lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "git" {
  config.modules.homeManager.programs.git.enable = true;
  imports = [../../../../../../modules/homeManager/programs/git];
}
