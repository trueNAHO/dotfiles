lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gpg-agent" {
  config.modules.homeManager.services.gpg-agent.enable = true;
  imports = [../../../../../../modules/homeManager/services/gpg-agent];
}
