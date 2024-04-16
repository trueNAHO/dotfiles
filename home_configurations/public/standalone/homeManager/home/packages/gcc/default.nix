lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gcc" {
  config.modules.homeManager.home.packages.gcc.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/gcc];
}
