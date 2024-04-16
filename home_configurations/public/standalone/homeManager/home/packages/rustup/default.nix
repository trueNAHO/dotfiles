lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "rustup" {
  config.modules.homeManager.home.packages.rustup.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/rustup];
}
