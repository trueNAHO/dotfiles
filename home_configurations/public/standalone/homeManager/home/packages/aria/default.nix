lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "aria" {
  config.modules.homeManager.home.packages.aria.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/aria];
}
