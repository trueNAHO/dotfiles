lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "zellij" {
  config.modules.homeManager.programs.zellij.enable = true;
  imports = [../../../../../../modules/homeManager/programs/zellij];
}
