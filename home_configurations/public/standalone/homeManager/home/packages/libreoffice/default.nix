lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "libreoffice" {
  config.modules.homeManager.home.packages.libreoffice.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/libreoffice
  ];
}
