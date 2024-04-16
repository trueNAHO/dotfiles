lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "pstree" {
  config.modules.homeManager.home.packages.pstree.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/pstree];
}
