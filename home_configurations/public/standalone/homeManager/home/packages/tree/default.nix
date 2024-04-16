lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "tree" {
  config.modules.homeManager.home.packages.tree.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/tree];
}
