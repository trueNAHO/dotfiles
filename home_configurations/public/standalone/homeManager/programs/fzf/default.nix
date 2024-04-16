lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "fzf" {
  config.modules.homeManager.programs.fzf.enable = true;
  imports = [../../../../../../modules/homeManager/programs/fzf];
}
