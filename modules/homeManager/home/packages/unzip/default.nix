{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.unzip.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.unzip";

  config = lib.mkIf config.modules.homeManager.home.packages.unzip.enable {
    home.packages = [pkgs.unzip];
  };
}
