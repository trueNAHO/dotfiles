lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "thunderbird" {
  config.modules.homeManager.home.packages.thunderbird.enable = true;

  imports = [
    ../../../../../../../modules/homeManager/home/packages/thunderbird
  ];
}
