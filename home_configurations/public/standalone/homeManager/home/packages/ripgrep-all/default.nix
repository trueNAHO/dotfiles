lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "ripgrep-all" {
  config.modules.homeManager.home.packages.ripgrep-all.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/ripgrep-all
  ];
}
