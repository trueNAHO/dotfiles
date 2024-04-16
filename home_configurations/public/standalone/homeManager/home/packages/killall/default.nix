lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "killall" {
  config.modules.homeManager.home.packages.killall.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/killall];
}
