lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "procs" {
  config.modules.homeManager.home.packages.procs.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/procs];
}
