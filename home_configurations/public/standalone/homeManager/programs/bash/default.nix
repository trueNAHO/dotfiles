lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "bash" {
  config.modules.homeManager.programs.bash.enable = true;
  imports = [../../../../../../modules/homeManager/programs/bash];
}
