lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "catnip" {
  config.modules.homeManager.home.packages.catnip.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/catnip];
}
