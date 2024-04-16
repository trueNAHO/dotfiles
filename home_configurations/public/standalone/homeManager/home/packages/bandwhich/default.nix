lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "bandwhich" {
  config.modules.homeManager.home.packages.bandwhich.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/bandwhich];
}
