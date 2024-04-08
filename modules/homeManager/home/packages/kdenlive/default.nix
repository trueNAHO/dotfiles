{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.kdenlive.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.kdenlive";

  config = lib.mkIf config.modules.homeManager.home.packages.kdenlive.enable {
    home.packages = [pkgs.libsForQt5.kdenlive];
  };
}
