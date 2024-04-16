lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "eza" {
  config.modules.homeManager.programs.eza.enable = true;
  imports = [../../../../../../modules/homeManager/programs/eza];
}
