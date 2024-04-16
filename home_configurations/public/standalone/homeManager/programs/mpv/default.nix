lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "mpv" {
  config.modules.homeManager.programs.mpv.enable = true;
  imports = [../../../../../../modules/homeManager/programs/mpv];
}
