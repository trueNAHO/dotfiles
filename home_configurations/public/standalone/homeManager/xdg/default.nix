lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "xdg" {
  config.modules.homeManager.xdg.enable = true;
  imports = [../../../../../modules/homeManager/xdg];
}
