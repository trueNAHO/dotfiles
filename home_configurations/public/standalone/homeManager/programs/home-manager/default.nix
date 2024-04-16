lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "home-manager" {
  config.modules.homeManager.programs.home-manager.enable = true;
  imports = [../../../../../../modules/homeManager/programs/home-manager];
}
