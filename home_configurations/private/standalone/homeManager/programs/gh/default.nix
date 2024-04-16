lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gh" {
  config.modules.homeManager.programs.gh.enable = true;
  imports = [../../../../../../modules/homeManager/programs/gh];
}
