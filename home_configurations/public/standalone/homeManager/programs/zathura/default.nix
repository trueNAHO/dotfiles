lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "zathura" {
  config.modules.homeManager.programs.zathura.enable = true;
  imports = [../../../../../../modules/homeManager/programs/zathura];
}
