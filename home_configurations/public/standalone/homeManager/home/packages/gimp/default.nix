lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gimp" {
  config.modules.homeManager.home.packages.gimp.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/gimp];
}
