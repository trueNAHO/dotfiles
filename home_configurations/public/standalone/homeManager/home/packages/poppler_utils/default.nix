lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "poppler_utils" {
  config.modules.homeManager.home.packages.poppler_utils.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/poppler_utils
  ];
}
