lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "glava" {
  config.modules.homeManager.home.packages.glava.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/glava];
}
