lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "pipe-rename" {
  config.modules.homeManager.home.packages.pipe-rename.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/pipe-rename
  ];
}
