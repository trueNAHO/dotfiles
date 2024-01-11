{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.ffmpeg.enable =
    lib.mkEnableOption "ffmpeg";

  config = lib.mkIf config.modules.homeManager.home.packages.ffmpeg.enable {
    home.packages = [pkgs.ffmpeg];
  };
}
