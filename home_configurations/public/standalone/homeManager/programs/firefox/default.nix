lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "firefox" {
  config.modules.homeManager.programs.firefox.enable = true;
  imports = [../../../../../../modules/homeManager/programs/firefox];
}
