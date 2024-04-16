lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "dua" {
  config.modules.homeManager.home.packages.dua.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/dua];
}
