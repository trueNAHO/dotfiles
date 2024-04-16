lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "dunst" {
  config.modules.homeManager.services.dunst.enable = true;
  imports = [../../../../../../modules/homeManager/services/dunst];
}
