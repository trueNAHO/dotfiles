{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.file.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.file";

  config = lib.mkIf config.modules.homeManager.home.packages.file.enable {
    home.packages = [pkgs.file];
  };
}
