lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "zip" {
  config.modules.homeManager.home.packages.zip.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/zip];
}
