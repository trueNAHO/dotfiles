lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "diskonaut" {
  config.modules.homeManager.home.packages.diskonaut.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/diskonaut];
}
