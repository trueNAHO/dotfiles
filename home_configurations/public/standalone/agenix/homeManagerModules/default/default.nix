lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "default" {
  config.modules.agenix.homeManagerModules.default.enable = true;
  imports = [../../../../../../modules/agenix/homeManagerModules/default];
}
