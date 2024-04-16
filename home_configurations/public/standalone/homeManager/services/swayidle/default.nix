lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "swayidle" {
  config.modules.homeManager.services.swayidle.enable = true;
  imports = [../../../../../../modules/homeManager/services/swayidle];
}
