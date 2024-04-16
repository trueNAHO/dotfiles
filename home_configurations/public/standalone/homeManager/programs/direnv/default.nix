lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "direnv" {
  config.modules.homeManager.programs.direnv.enable = true;
  imports = [../../../../../../modules/homeManager/programs/direnv];
}
