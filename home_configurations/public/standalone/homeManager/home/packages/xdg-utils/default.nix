lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "xdg-utils" {
  config.modules.homeManager.home.packages.xdg-utils.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/xdg-utils];
}
