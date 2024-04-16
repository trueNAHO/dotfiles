lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gammastep" {
  config.modules.homeManager.services.gammastep.enable = true;
  imports = [../../../../../../modules/homeManager/services/gammastep];
}
