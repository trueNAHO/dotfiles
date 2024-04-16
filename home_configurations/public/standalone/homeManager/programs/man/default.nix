lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "man" {
  config.modules.homeManager.programs.man.enable = true;
  imports = [../../../../../../modules/homeManager/programs/man];
}
