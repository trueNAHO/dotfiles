lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gping" {
  config.modules.homeManager.home.packages.gping.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/gping];
}
