lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "parallel" {
  config.modules.homeManager.home.packages.parallel.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/parallel];
}
