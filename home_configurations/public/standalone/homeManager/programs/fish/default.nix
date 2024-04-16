lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "fish" {
  config.modules.homeManager.programs.fish.enable = true;
  imports = [../../../../../../modules/homeManager/programs/fish];
}
