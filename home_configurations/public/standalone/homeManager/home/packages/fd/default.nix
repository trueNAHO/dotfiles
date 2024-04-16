lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "fd" {
  config.modules.homeManager.home.packages.fd.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/fd];
}
