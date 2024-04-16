lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "tldr" {
  config.modules.homeManager.home.packages.tldr.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/tldr];
}
