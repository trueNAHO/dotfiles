lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "ripgrep" {
  config.modules.homeManager.programs.ripgrep.enable = true;
  imports = [../../../../../../modules/homeManager/programs/ripgrep];
}
