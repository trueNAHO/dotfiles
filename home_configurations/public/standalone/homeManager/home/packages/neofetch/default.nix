lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "neofetch" {
  config.modules.homeManager.home.packages.neofetch.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/neofetch];
}
