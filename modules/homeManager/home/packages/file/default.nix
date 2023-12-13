{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.file.enable =
    lib.mkEnableOption "file";

  config = lib.mkIf config.modules.homeManager.home.packages.file.enable {
    home.packages = [pkgs.file];
  };
}
