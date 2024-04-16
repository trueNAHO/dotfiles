lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "borgmatic" {
  config.modules.homeManager.services.borgmatic.enable = true;
  imports = [../../../../../../modules/homeManager/services/borgmatic];
}
