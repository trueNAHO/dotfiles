lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "ffmpeg" {
  config.modules.homeManager.home.packages.ffmpeg.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/ffmpeg];
}
