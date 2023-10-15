{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.killall.enable =
    lib.mkEnableOption "killall";

  config = lib.mkIf config.modules.homeManager.home.packages.killall.enable {
    home.packages = [pkgs.killall];
  };
}
