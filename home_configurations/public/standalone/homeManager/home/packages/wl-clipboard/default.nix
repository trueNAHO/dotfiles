lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "wl-clipboard" {
  config.modules.homeManager.home.packages.wl-clipboard.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/wl-clipboard
  ];
}
