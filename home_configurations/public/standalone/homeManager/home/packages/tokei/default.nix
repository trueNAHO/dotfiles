lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "tokei" {
  config.modules.homeManager.home.packages.tokei.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/tokei];
}
