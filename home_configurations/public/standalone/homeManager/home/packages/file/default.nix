lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "file" {
  config.modules.homeManager.home.packages.file.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/file];
}
