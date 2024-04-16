lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "battery" {
  config.modules.services.battery.enable = true;
  imports = [../../../../../modules/services/battery];
}
