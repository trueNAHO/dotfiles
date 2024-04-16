lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "rofi" {
  config.modules.homeManager.programs.rofi.enable = true;
  imports = [../../../../../../modules/homeManager/programs/rofi];
}
