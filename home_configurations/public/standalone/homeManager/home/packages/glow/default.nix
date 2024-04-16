lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "glow" {
  config.modules.homeManager.home.packages.glow.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/glow];
}
