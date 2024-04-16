lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "catimg" {
  config.modules.homeManager.home.packages.catimg.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/catimg];
}
