lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "kitty" {
  config.modules.homeManager.programs.kitty.enable = true;
  imports = [../../../../../../modules/homeManager/programs/kitty];
}
