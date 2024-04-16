lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "easyeffects" {
  config.modules.homeManager.services.easyeffects.enable = true;
  imports = [../../../../../../modules/homeManager/services/easyeffects];
}
