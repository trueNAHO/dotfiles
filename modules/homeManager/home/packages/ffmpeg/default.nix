{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.ffmpeg.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.ffmpeg";

  config = lib.mkIf config.modules.homeManager.home.packages.ffmpeg.enable {
    home.packages = [pkgs.ffmpeg];
  };
}
