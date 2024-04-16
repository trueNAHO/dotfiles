lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "feh" {
  config.modules.homeManager.programs.feh.enable = true;
  imports = [../../../../../../modules/homeManager/programs/feh];
}
