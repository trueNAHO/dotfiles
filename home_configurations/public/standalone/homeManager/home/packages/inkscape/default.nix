lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "inkscape" {
  config.modules.homeManager.home.packages.inkscape.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/inkscape];
}
