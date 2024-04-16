lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "bat" {
  config.modules.homeManager.programs.bat.enable = true;
  imports = [../../../../../../modules/homeManager/programs/bat];
}
