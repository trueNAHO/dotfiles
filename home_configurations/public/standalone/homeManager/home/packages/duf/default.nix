lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "duf" {
  config.modules.homeManager.home.packages.duf.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/duf];
}
