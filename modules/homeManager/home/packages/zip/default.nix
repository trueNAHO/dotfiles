{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.zip.enable =
    lib.mkEnableOption "zip";

  config = lib.mkIf config.modules.homeManager.home.packages.zip.enable {
    home.packages = [pkgs.zip];
  };
}
