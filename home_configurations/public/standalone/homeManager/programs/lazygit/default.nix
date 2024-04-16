lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "lazygit" {
  config.modules.homeManager.programs.lazygit.enable = true;
  imports = [../../../../../../modules/homeManager/programs/lazygit];
}
