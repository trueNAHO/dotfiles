lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "p7zip" {
  config.modules.homeManager.home.packages.p7zip.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/p7zip];
}
