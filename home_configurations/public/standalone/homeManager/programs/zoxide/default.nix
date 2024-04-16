lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "zoxide" {
  config.modules.homeManager.programs.zoxide.enable = true;
  imports = [../../../../../../modules/homeManager/programs/zoxide];
}
