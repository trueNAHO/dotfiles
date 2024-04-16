lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "wlogout" {
  config.modules.homeManager.programs.wlogout.enable = true;
  imports = [../../../../../../modules/homeManager/programs/wlogout];
}
