lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "swaylock" {
  config.modules.homeManager.programs.swaylock.enable = true;
  imports = [../../../../../../modules/homeManager/programs/swaylock];
}
