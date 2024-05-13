{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.ffmpeg.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.ffmpeg";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.ffmpeg.enable {
    home.packages = [pkgs.ffmpeg];
  };
}
