lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "du-dust" {
  config.modules.homeManager.home.packages.du-dust.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/du-dust];
}
