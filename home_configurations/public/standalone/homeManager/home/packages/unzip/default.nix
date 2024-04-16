lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "unzip" {
  config.modules.homeManager.home.packages.unzip.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/unzip];
}
