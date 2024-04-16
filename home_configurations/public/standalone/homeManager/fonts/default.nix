lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "fonts" {
  config.modules.homeManager.fonts.enable = true;
  imports = [../../../../../modules/homeManager/fonts];
}
