lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gpg" {
  config.modules.homeManager.programs.gpg.enable = true;
  imports = [../../../../../../modules/homeManager/programs/gpg];
}
