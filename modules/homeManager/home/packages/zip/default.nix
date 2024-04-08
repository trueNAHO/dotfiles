{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.zip.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.zip";

  config = lib.mkIf config.modules.homeManager.home.packages.zip.enable {
    home.packages = [pkgs.zip];
  };
}
