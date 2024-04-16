lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "borgmatic" {
  config.modules.homeManager.programs.borgmatic.enable = true;
  imports = [../../../../../../modules/homeManager/programs/borgmatic];
}
