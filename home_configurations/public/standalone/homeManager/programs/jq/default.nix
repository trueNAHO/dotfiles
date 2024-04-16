lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "jq" {
  config.modules.homeManager.programs.jq.enable = true;
  imports = [../../../../../../modules/homeManager/programs/jq];
}
