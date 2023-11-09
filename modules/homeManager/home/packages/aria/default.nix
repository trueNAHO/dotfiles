{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.aria.enable =
    lib.mkEnableOption "aria";

  config = lib.mkIf config.modules.homeManager.home.packages.aria.enable {
    home.packages = [pkgs.aria];
  };
}
