lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "btop" {
  config.modules.homeManager.programs.btop.enable = true;
  imports = [../../../../../../modules/homeManager/programs/btop];
}
