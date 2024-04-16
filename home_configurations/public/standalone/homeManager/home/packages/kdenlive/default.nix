lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "kdenlive" {
  config.modules.homeManager.home.packages.kdenlive.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/kdenlive];
}
