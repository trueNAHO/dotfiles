{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.bandwhich.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.bandwhich";

  config = lib.mkIf config.modules.homeManager.home.packages.bandwhich.enable {
    home.packages = [pkgs.bandwhich];
  };
}
