lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "xplr" {
  config.modules.homeManager.programs.xplr.enable = true;
  imports = [../../../../../../modules/homeManager/programs/xplr];
}
