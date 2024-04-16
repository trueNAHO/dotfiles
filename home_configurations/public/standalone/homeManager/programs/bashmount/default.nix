lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "bashmount" {
  config.modules.homeManager.programs.bashmount.enable = true;
  imports = [../../../../../../modules/homeManager/programs/bashmount];
}
