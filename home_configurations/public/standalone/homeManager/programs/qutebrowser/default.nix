lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "qutebrowser" {
  config.modules.homeManager.programs.qutebrowser.enable = true;
  imports = [../../../../../../modules/homeManager/programs/qutebrowser];
}
